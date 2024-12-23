import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/models/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends Notifier<ThemeState> {
  static const _themeModeKey = 'themeMode';
  static const _themeColorKey = 'themeColor';

  @override
  ThemeState build() {
    _initialize();
    return ThemeState(AppThemeMode.system, ThemeColor.purple);
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final modeName = prefs.getString(_themeModeKey);
    final colorName = prefs.getString(_themeColorKey);

    final themeMode = AppThemeMode.values.firstWhere(
      (e) => e.name == modeName,
      orElse: () => AppThemeMode.system,
    );

    final themeColor = ThemeColor.values.firstWhere(
      (e) => e.name == colorName,
      orElse: () => ThemeColor.purple,
    );

    state = ThemeState(themeMode, themeColor);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.name);
  }

  Future<void> setThemeColor(ThemeColor color) async {
    state = state.copyWith(themeColor: color);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeColorKey, color.name);
  }
}

final themeController = NotifierProvider<ThemeController, ThemeState>(() {
  return ThemeController();
});
