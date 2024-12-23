import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/views/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeController);
    return MaterialApp(
      title: 'Just Think',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
