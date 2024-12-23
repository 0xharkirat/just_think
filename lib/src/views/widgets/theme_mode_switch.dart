import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:just_think/src/core/extensions.dart';


class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeControllerNotifier = ref.read(themeController.notifier);

    return PopupMenuButton<AppThemeMode>(
      icon: const Icon(
        Icons.brightness_6, // Use any icon you like here
      ),
      onSelected: (AppThemeMode newMode) {
        themeControllerNotifier.setThemeMode(newMode);
      },
      initialValue: ref.watch(themeController).themeMode,
      tooltip: "Change theme",
      itemBuilder: (BuildContext context) {
        return AppThemeMode.values.map((AppThemeMode mode) {
          return PopupMenuItem<AppThemeMode>(
            value: mode,
            child: Row(
              children: [
                Icon(
                  mode == AppThemeMode.dark
                      ? Icons.dark_mode
                      : mode == AppThemeMode.light
                          ? Icons.light_mode
                          : Icons.brightness_auto,
                ),
                const SizedBox(width: 8),
                Text(mode.name.capitalize()),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
