import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppThemeMode { system, light, dark }

enum ThemeColor { purple, orange, pink, yellow, green, blue }

class AppTheme {
  static ThemeData getLightTheme(MaterialAccentColor seedColor) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: GoogleFonts.manrope().fontFamily,
    );
  }

  static ThemeData getDarkTheme(MaterialAccentColor seedColor) {
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
  MaterialAccentColor get materialColor {
    switch (this) {

      case ThemeColor.purple:
        return Colors.deepPurpleAccent;
      case ThemeColor.orange:
        return Colors.deepOrangeAccent;
      case ThemeColor.pink:
        return Colors.pinkAccent;
      case ThemeColor.yellow:
        return Colors.yellowAccent;
      case ThemeColor.green:
        return Colors.greenAccent;
      case ThemeColor.blue:
        return Colors.blueAccent;
      default:
        return Colors.greenAccent;
    }
  }
}
