import 'package:just_think/src/core/app_theme.dart';

class ThemeState {
  final AppThemeMode themeMode;
  final ThemeColor themeColor;

  ThemeState(this.themeMode, this.themeColor);

  ThemeState copyWith({AppThemeMode? themeMode, ThemeColor? themeColor}) {
    return ThemeState(
      themeMode ?? this.themeMode,
      themeColor ?? this.themeColor,
    );
  }
}