import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  static const _eventChannel =
      EventChannel('com.hsi.harki.just_think/blocked_app_events');
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();
    ref.read(installedAppsController);

    // Listen for blocked app events from native AccessibilityService
    _eventSubscription = _eventChannel.receiveBroadcastStream().listen((event) {
      log("Blocked app event received: $event");
      if (event is Map) {
        final packageName = event['packageName'] as String?;
        if (packageName != null) {
          // Look up the app name from selected apps
          final selectedApps = ref.read(selectedAppsController);
          final appName =
              selectedApps.asData?.value[packageName]?.name ?? packageName;
          ref
              .read(blockedAppController.notifier)
              .setBlockedApp(packageName, appName);
        }
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
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
