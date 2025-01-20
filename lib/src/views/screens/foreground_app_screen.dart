import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForegroundAppScreen extends StatefulWidget {
  const ForegroundAppScreen({super.key});

  @override
  State<ForegroundAppScreen> createState() => _ForegroundAppScreenState();
}

class _ForegroundAppScreenState extends State<ForegroundAppScreen> {
  static const eventChannel = EventChannel('com.example.just_think/foreground_app');
  static const platform = MethodChannel('com.example.just_think/foreground');
  String currentApp = "Unknown";

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(
          (event) {
        setState(() {
          currentApp = event; // Update the UI with the received app name
        });
        print("Received foreground app: $event"); // Log received data
      },
      onError: (error) {
        print("Error receiving event: $error");
      },
    );
  }


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
      appBar: AppBar(title: const Text("Foreground App Tracker"),
        actions: [
          IconButton(onPressed: redirectToUsageAccessSettings, icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Text("Current App: $currentApp"),
      ),
    );
  }
}
