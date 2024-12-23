import 'package:flutter/material.dart';
import 'package:just_think/src/views/widgets/all_apps_widget.dart';
import 'package:just_think/src/views/widgets/selected_apps_widget.dart';
import 'package:just_think/src/views/widgets/theme_color_switch.dart';
import 'package:just_think/src/views/widgets/theme_mode_switch.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Just Think"),
        actions: const [
          ThemeColorSwitch(),
          ThemeModeSwitch(),
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
