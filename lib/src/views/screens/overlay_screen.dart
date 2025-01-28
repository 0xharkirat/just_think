import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';


class OverlayScreen extends ConsumerWidget {
  const OverlayScreen({super.key});

  static const MethodChannel _channel =
      MethodChannel('com.example.just_think/navigation');

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
    final blockedApp = ref.watch(blockedAppController);
    final packageName = blockedApp?[0];
    final appName = blockedApp?[1];

    return WillPopScope(
      onWillPop: () async {
        ref.read(blockedAppController.notifier).removeBlockedApp();
        goToHomeScreen();

        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to open $appName?"),
              ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(selectedAppsController.notifier)
                        .unblockApp(packageName!);
                    ref.read(blockedAppController.notifier).removeBlockedApp();
                    ref
                        .read(installedAppsController.notifier)
                        .openApp(packageName);
                  },
                  child: Text("Yes, Open $appName")),

              // create a button to close the twitter
              ElevatedButton(
                  onPressed: () {
                    ref.read(blockedAppController.notifier).removeBlockedApp();
                    goToHomeScreen();
                  },
                  child: Text("No, Close $appName")),
            ],
          ),
        ),
      ),
    );
  }
}
