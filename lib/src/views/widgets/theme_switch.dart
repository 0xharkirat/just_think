import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/theme_controller.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        ref.watch(themeController) ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () {
        ref.read(themeController.notifier).toggleTheme();
      },
    );
  }
}
