import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';

class OverlayScreen extends ConsumerWidget {
  const OverlayScreen({super.key});

  static const MethodChannel _channel = MethodChannel('com.example.just_think/navigation');

  /// Navigate to the phone's home screen
  static Future<void> goToHomeScreen() async {
    try {
      await _channel.invokeMethod('goToHome');
    } on PlatformException catch (e) {
      // Handle any errors
      debugPrint("Failed to go to home screen: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        goToHomeScreen();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to open Twitter?"),
              ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(selectedAppsController.notifier)
                        .unblockApp("com.twitter.android");
      
                    ref
                        .read(installedAppsController.notifier)
                        .openApp("com.twitter.android");
                  },
                  child: Text("Yes, Open Twitter")),
      
              // create a button to close the twitter
              ElevatedButton(onPressed: () {
                goToHomeScreen();
              }, child: Text("No, Close Twitter")),
            ],
          ),
        ),
      ),
    );
  }
}
