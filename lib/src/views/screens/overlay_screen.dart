import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';
import 'package:just_think/src/controllers/theme_controller.dart';
import 'package:just_think/src/core/app_theme.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

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
    Animate.restartOnHotReload = true;
    final themeMode = ref.watch(themeController).themeMode; 

    return WillPopScope(
      onWillPop: () async {
        ref.read(blockedAppController.notifier).removeBlockedApp();
        goToHomeScreen();

        return false;
      },
      child: AnimatedMeshGradient(
        colors: [
          Theme.of(context).colorScheme.onTertiary,
          Theme.of(context).colorScheme.onPrimary,
          Theme.of(context).colorScheme.inversePrimary,
          Theme.of(context).colorScheme.onSecondary,
        ],
        options: AnimatedMeshGradientOptions(
          grain: 0.2,
        ),
        child: Scaffold(
          backgroundColor:  themeMode == AppThemeMode.light? Colors.transparent: Colors.black45,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Just Think",
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center)
                      .animate()
                      .fadeIn(
                          delay: 0.2.seconds,
                          duration: 1.2.seconds,
                          begin: 0,
                          curve: Curves.easeIn),
                  const SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      text: "Are you sure you want to open",
                      children: [
                        TextSpan(
                          text: "\n$appName",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        TextSpan(
                          text: " ?",
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ).animate().fadeIn(delay: 1.seconds, duration: 1.6.seconds),
          
                  const SizedBox(height: 40),
          
                  // create a button to close the twitter
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                    ),
                    onPressed: () {
                      ref.read(blockedAppController.notifier).removeBlockedApp();
                      goToHomeScreen();
                    },
                    child: Text(
                      "No, I choose peace of mind.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                      .animate()
                      .fadeIn(
                          delay: 1.4.seconds, duration: 2.seconds) // Runs once
                      .then() // After fade-in completes
                      .animate(
                        onPlay: (controller) => controller.repeat(
                          reverse:
                              false, // No reverse; let the animation loop naturally
                        ),
                      )
                      .then(
                          delay:
                              1.seconds) // Short pause before the shimmer starts
                      .shimmer(
                        angle: 0.5,
                        duration:
                            2.seconds, // Calming shimmer effect for "inhale"
                      )
                      .scaleXY(
                        end: 1.2, // Slowly scale up to represent "inhale"
                        duration: 2.5.seconds,
                        curve: Curves
                            .easeInOutCubic, // Smooth scaling for a calm effect
                      )
                      .then(delay: 1.seconds) // Hold the breath (pause)
                      .scaleXY(
                        end: 1 /
                            1.2, // Slowly scale back down to represent "exhale"
                        duration: 2.5.seconds,
                        curve:
                            Curves.easeInOutCubic, // Smooth scaling for "exhale"
                      ),
                  // Scale down for 1/3 of the cycle
          
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      await ref
                          .read(selectedAppsController.notifier)
                          .unblockApp(packageName!);
                      ref.read(blockedAppController.notifier).removeBlockedApp();
                      ref
                          .read(installedAppsController.notifier)
                          .openApp(packageName);
                    },
                    child: Text(
                      "Yes, but I'll use it wisely",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ).animate().fadeIn(delay: 1.8.seconds, duration: 2.seconds),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
