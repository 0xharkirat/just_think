import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:current_app/current_app.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import 'package:just_think/src/models/app_info_wrapper.dart';
import 'package:path_provider/path_provider.dart';

const notificationChannelId = 'just_think_notifications';
const notificationId = 888;

/// Cooldown duration before re-enabling blocking for an app after user allows it.
const reBlockCooldown = Duration(seconds: 10);

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'Just Think Notifications',
    description: 'Notification channel for Just Think App',
    importance: Importance.low,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Just Think',
      initialNotificationContent: 'Monitoring apps',
      foregroundServiceNotificationId: notificationId,
      foregroundServiceTypes: [AndroidForegroundType.dataSync],
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final CurrentApp currentApp = CurrentApp();

  // Open Isar in the background isolate
  Isar? isar;
  try {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([AppInfoWrapperSchema], directory: dir.path);
  } catch (e) {
    log("Failed to open Isar in background service: $e");
    return;
  }

  // Local cache of tracked packages
  final Map<String, Map<String, dynamic>> packageNames = {};

  // Track recently unblocked apps to prevent immediate re-blocking
  final Map<String, DateTime> recentlyUnblocked = {};

  Future<void> refreshPackageCache() async {
    final storedWrappers = await isar!.appInfoWrappers.where().findAll();
    packageNames.clear();
    for (var wrapper in storedWrappers) {
      packageNames[wrapper.packageName] = {
        "appName": wrapper.appName,
        "shouldBlock": wrapper.shouldBlock,
      };
    }
    log("Package cache refreshed: ${packageNames.length} apps tracked");
  }

  // Initial load
  await refreshPackageCache();

  // Watch for DB changes
  isar.appInfoWrappers.watchLazy().listen((_) async {
    await refreshPackageCache();
  });

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) async {
    await isar?.close();
    service.stopSelf();
  });

  // Monitor foreground app
  currentApp.getForegroundAppStream().listen((packageName) async {
    if (packageName == null) return;
    if (!packageNames.containsKey(packageName)) return;

    final appData = packageNames[packageName]!;
    final shouldBlock = appData['shouldBlock'] == true;
    final appName = appData['appName'] as String?;

    if (shouldBlock) {
      // Check cooldown — don't block if recently unblocked
      final unblockedAt = recentlyUnblocked[packageName];
      if (unblockedAt != null &&
          DateTime.now().difference(unblockedAt) < reBlockCooldown) {
        log("Skipping block for $packageName — still in cooldown");
        return;
      }

      log("Blocking app: $packageName");
      await currentApp.bringToForeground();
      service.invoke('redirectToOverlay', {
        'packageName': packageName,
        'appName': appName ?? packageName,
      });
    } else {
      log("App allowed (shouldBlock=false): $packageName");

      // Re-enable blocking after cooldown
      recentlyUnblocked[packageName] = DateTime.now();

      final wrapper = await isar!.appInfoWrappers
          .filter()
          .packageNameEqualTo(packageName)
          .findFirst();
      if (wrapper != null) {
        await isar.writeTxn(() async {
          wrapper.shouldBlock = true;
          await isar!.appInfoWrappers.put(wrapper);
        });
      }
    }
  });
}
