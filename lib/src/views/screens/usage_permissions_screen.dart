import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GrantPermissionScreen extends StatelessWidget {
  static const platform = MethodChannel('com.example.just_think/foreground');

  const GrantPermissionScreen({super.key});

  Future<void> redirectToUsageAccessSettings() async {
    try {
      await platform.invokeMethod('redirectToUsageAccessSettings');
    } on PlatformException catch (e) {
      print("Failed to open settings: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grant Permission')),
      body: Center(
        child: ElevatedButton(
          onPressed: redirectToUsageAccessSettings,
          child: Text('Grant Usage Access'),
        ),
      ),
    );
  }
}
