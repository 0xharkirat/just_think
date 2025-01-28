import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/controllers/selected_apps_controller.dart';

class OverlayScreen extends ConsumerWidget {
  const OverlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Overlay Screen"),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(selectedAppsController.notifier)
                      .unblockApp("com.twitter.android");
                },
                child: Text("Open Overlay"))
          ],
        ),
      ),
    );
  }
}
