import 'dart:developer';

import 'package:current_app/current_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForegroundAppScreen extends StatefulWidget {
  const ForegroundAppScreen({super.key});

  @override
  State<ForegroundAppScreen> createState() => _ForegroundAppScreenState();
}

class _ForegroundAppScreenState extends State<ForegroundAppScreen> {
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
        title: Text('Foreground App'),
        actions: [IconButton(onPressed: redirectToUsageAccessSettings, icon: Icon(Icons.settings))],
      ),
      body: Center(
        child: Text('Current App: null'),
      ),
    );
  }
}
