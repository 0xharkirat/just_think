import 'package:flutter/material.dart';
import 'package:just_think/src/views/widgets/app_listview_widget.dart';
import 'package:just_think/src/views/widgets/theme_color_switch.dart';
import 'package:just_think/src/views/widgets/theme_mode_switch.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: const [
          ThemeColorSwitch(),
          ThemeModeSwitch(),
        ],
      ),
      body: const AppListViewWidget(),
    );
  }
}
