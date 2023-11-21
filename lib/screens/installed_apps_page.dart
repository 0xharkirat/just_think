import 'package:flutter/material.dart';
import 'package:just_think/widgets/app_tile.dart';

class InstalledAppsPage extends StatelessWidget {
  const InstalledAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Installed Apps"),
      ),
      body: ListView(
        children: [
          AppTile(),
          AppTile(),
          AppTile(),
          AppTile(),

        ],
      ),
    );
  }
}
