import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/core/extensions.dart';

class ThemeColorSwitch extends ConsumerWidget {
  const ThemeColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeControllerNotifier = ref.read(themeController.notifier);

    return PopupMenuButton<ThemeColor>(
      icon: const Icon(
        Icons.colorize, // Use any icon you like here
      ),
      onSelected: (ThemeColor newColor) {
        themeControllerNotifier.setThemeColor(newColor);
      },
      initialValue: ref.watch(themeController).themeColor,
      tooltip: "Change Color",
      itemBuilder: (BuildContext context) {
        return ThemeColor.values.map((ThemeColor color) {
          return PopupMenuItem<ThemeColor>(
            value: color,
            child: Text(color.name.capitalize()),
          );
        }).toList();
      },
    );
  }
}
