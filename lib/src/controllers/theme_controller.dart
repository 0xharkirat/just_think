import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }
  void toggleTheme() {
    state = !state;
  }
  
}

final themeController = NotifierProvider<ThemeController, bool>(() {
  return ThemeController();
});