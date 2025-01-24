import 'dart:developer';

import 'package:current_app/current_app.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> openAppWithOverlay(String url) async {
    if (await canLaunchUrl(Uri.parse("https://youtube.com"))) {
      await launchUrl(Uri.parse("https://youtube.com"));
    } else {
      log('Could not launch app with URL: https://youtube.com');
    }
  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foreground App'),
        actions: [
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Foreground App'),
          ],
        ),
      ),
    );
  }
}
