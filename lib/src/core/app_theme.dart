import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeMode { system, light, dark }

enum ThemeColor { purple, orange, pink, yellow, green, blue }

class AppTheme {
  static ThemeData getLightTheme(MaterialColor seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: GoogleFonts.manrope().fontFamily,
    );
  }

  static ThemeData getDarkTheme(MaterialColor seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: GoogleFonts.manrope().fontFamily,
    );
  }
}

extension AppThemeModeExtension on AppThemeMode {
  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

extension ThemeColorExtension on ThemeColor {
  MaterialColor get materialColor {
    switch (this) {
      case ThemeColor.purple:
        return Colors.deepPurple;
      case ThemeColor.orange:
        return Colors.deepOrange;
      case ThemeColor.pink:
        return Colors.pink;
      case ThemeColor.yellow:
        return Colors.yellow;
      case ThemeColor.green:
        return Colors.green;
      case ThemeColor.blue:
        return Colors.blue;
      default:
        return Colors.deepPurple;
    }
  }
}
