import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/views/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(installedAppsController);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeController);

    return MaterialApp(
      title: 'Just Think',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.getDarkTheme(themeState.themeColor.materialColor),
      theme: AppTheme.getLightTheme(themeState.themeColor.materialColor),
      themeMode: themeState.themeMode.themeMode,
      home: const HomeScreen(),
    );
  }
}
