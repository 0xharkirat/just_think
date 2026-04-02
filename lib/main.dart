import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/core/background_service.dart';
import 'package:just_think/src/core/router.dart';

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
  final FlutterBackgroundService _service = FlutterBackgroundService();
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    ref.read(installedAppsController);
    _streamSubscription = _service.on('redirectToOverlay').listen((event) {
      log("Event Received: $event");
      if (event == null) return;
      final packageName = event['packageName'] as String?;
      final appName = event['appName'] as String?;
      if (packageName != null && appName != null) {
        ref
            .read(blockedAppController.notifier)
            .setBlockedApp(packageName, appName);
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
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
