import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class ThemeController extends Notifier<AppThemeMode> {
  static const _themeKey = 'themeMode';

  @override
  AppThemeMode build() {
    // Default to system theme and initialize asynchronously
    _initializeTheme();
    return AppThemeMode.system;
  }

  Future<void> _initializeTheme() async {
    final mode = await _loadThemeMode();
    state = mode;
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = mode;
    await _saveThemeMode(mode);
  }

  Future<AppThemeMode> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getString(_themeKey);

      return AppThemeMode.values.firstWhere(
        (e) => e.name == savedMode,
        orElse: () => AppThemeMode.system,
      );
    } catch (e) {
      // Handle any errors gracefully and default to system theme
      return AppThemeMode.system;
    }
  }

  Future<void> _saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  ThemeMode getThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

final themeController = NotifierProvider<ThemeController, AppThemeMode>(() {
  return ThemeController();
});
