import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:current_app/current_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/core/router.dart';
import 'package:just_think/src/models/app_info_wrapper.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  final FlutterBackgroundService service = FlutterBackgroundService();

  // stream to listen to the current app
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    ref.read(installedAppsController);
    _streamSubscription = service.on('redirectToOverlay').listen((event) {
      log("Event Received: $event");
      if (event != null) {
        ref.read(blockedAppStateProvider.notifier).state = event['packageName'];
      }
    });
     
  }

  @override
  void dispose() {
    
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeController);
    final appRouter = ref.watch(goRouter);

    return MaterialApp.router(
      title: 'Just Think',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.getDarkTheme(themeState.themeColor.materialColor),
      theme: AppTheme.getLightTheme(themeState.themeColor.materialColor),
      themeMode: themeState.themeMode.themeMode,
      routerConfig: appRouter,
    );
  }
}

// this will be used as notification channel id
const notificationChannelId = 'just_think_notifications';

// this will be used for notification id, So you can update your custom notification with this id.
const notificationId = 888;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'Just Think Notifications', // title
    description: 'Notification channel for Just Think App', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Just Think',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: notificationId,
      foregroundServiceTypes: [AndroidForegroundType.dataSync],
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  final CurrentApp currentApp = CurrentApp(); // Initialize CurrentApp plugin

// Open a new Isar instance in the service isolate
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([AppInfoWrapperSchema], directory: dir.path);

  // Watch for changes in the appInfoWrappers collection
  final collectionStream = isar.appInfoWrappers.watchLazy();
  final Map<String, bool> packageNames = {}; // Keep track of current package names in the database
  final storedWrappers = await isar.appInfoWrappers.where().findAll();
    packageNames.clear(); // Clear the previous set of package names
    for (var wrapper in storedWrappers) {
      packageNames[wrapper.packageName] = wrapper.shouldBlock;
    }
    log("Updated Package Names when initializing: $packageNames");

  // Listen for changes in the database
  collectionStream.listen((_) async {

    final storedWrappers = await isar.appInfoWrappers.where().findAll();
    packageNames.clear(); // Clear the previous set of package names
    for (var wrapper in storedWrappers) {
      packageNames[wrapper.packageName] = wrapper.shouldBlock;
    }
    log("Updated Package Names in the stream: $packageNames");
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
    await isar.close();
    service.stopSelf();
  });

 
  // Listen to CurrentApp plugin's stream and update the notification dynamically
  currentApp.getForegroundAppStream().listen((packageName) async {
    if (packageName != null) {
      
      // Navigate to the OverlayScreen
      if (packageNames.containsKey(packageName)) {
        log("Match Found! Foreground App is in the database: $packageName");

        // Bring the app to the foreground and handle logic

        if (packageNames[packageName] == true) {
          log("Blocking the app: $packageName");
          await currentApp.bringToForeground();
          service.invoke('redirectToOverlay', {'packageName': packageName});
        } else {
          log("Not blocking the app: $packageName");
          /// change the shouldyBlock value true again.
          /// TODO: We need to maybe add a 5 second timer to block the app again if the required action is not taken
          final wrapper = await isar.appInfoWrappers.filter().packageNameEqualTo(packageName).findFirst();
          if (wrapper != null) {
            await isar.writeTxn(() async {
              wrapper.shouldBlock = true;
              isar.appInfoWrappers.put(wrapper);
            });
          }
         
        }
        
      } else {
        log("No match found for the foreground app: $packageName");
      }

      
    }
  });
}

// Update the notification with the current app name
      // flutterLocalNotificationsPlugin.show(
      //   notificationId,
      //   'Just Think',
      //   'Current App: $packageName',
      //   const NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       notificationChannelId,
      //       'Just Think SERVICE',
      //       icon: 'ic_bg_service_small',
      //       ongoing: true, // Keep the notification persistent
      //     ),
      //   ),
      // );


