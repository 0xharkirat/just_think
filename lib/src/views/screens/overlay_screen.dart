import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';
import 'package:just_think/src/core/router.dart';

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
    final packageName = ref.watch(blockedAppStateProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(blockedAppStateProvider.notifier).state = null;
        goToHomeScreen();

        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Do you want to open $packageName?"),
              ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(selectedAppsController.notifier)
                        .unblockApp(packageName!);
                    ref.read(blockedAppStateProvider.notifier).state = null;
                    ref
                        .read(installedAppsController.notifier)
                        .openApp(packageName);
                  },
                  child: Text("Yes, Open $packageName")),

              // create a button to close the twitter
              ElevatedButton(
                  onPressed: () {
                    ref.read(blockedAppStateProvider.notifier).state = null;
                    goToHomeScreen();
                  },
                  child: Text("No, Close $packageName")),
            ],
          ),
        ),
      ),
    );
  }
}
