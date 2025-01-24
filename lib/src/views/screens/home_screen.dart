import 'dart:developer';

import 'package:current_app/current_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:just_think/src/views/widgets/all_apps_widget.dart';
import 'package:just_think/src/views/widgets/selected_apps_widget.dart';
import 'package:just_think/src/views/widgets/theme_color_switch.dart';
import 'package:just_think/src/views/widgets/theme_mode_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final _currentApp = CurrentApp();

  void redirectToUsageAccessSettings() async {
    try {
      await _currentApp.redirectToUsageAccessSettings();
    } on PlatformException catch (e) {
      log("Failed to open app settings: ${e.message}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Just Think"),
        actions:  [
          ThemeColorSwitch(),
          ThemeModeSwitch(),
          IconButton(
            onPressed: redirectToUsageAccessSettings,
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              FlutterOverlayWindow.requestPermission();
            },
            icon: Icon(Icons.open_in_browser),
          ),
        ],
      ),
      body: const SelectedAppsWidget(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Select apps",
        onPressed: () {
          // open dialog to show app list view
          showDialog(
            context: context,
            builder: (context) {
              return const AllAppsWidget();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
