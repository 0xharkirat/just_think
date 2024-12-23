import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/views/screens/home_screen.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeController);
    return MaterialApp(
      title: 'Just Think',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.getDarkTheme(themeState.themeColor.materialColor),
      theme: AppTheme.getLightTheme(themeState.themeColor.materialColor),
      themeMode: themeState.themeMode.themeMode,
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

