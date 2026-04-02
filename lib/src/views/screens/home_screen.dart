import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_think/src/views/widgets/all_apps_widget.dart';
import 'package:just_think/src/views/widgets/selected_apps_widget.dart';
import 'package:just_think/src/views/widgets/theme_color_switch.dart';
import 'package:just_think/src/views/widgets/theme_mode_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static const _blockerChannel =
      MethodChannel('com.hsi.harki.just_think/blocker');

  bool _isAccessibilityEnabled = false;
  bool _isBatteryOptIgnored = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissions();
    }
  }

  Future<void> _checkPermissions() async {
    try {
      final a11y =
          await _blockerChannel.invokeMethod<bool>('isAccessibilityEnabled') ??
              false;
      final battery =
          await _blockerChannel.invokeMethod<bool>('isBatteryOptIgnored') ??
              false;
      if (mounted) {
        setState(() {
          _isAccessibilityEnabled = a11y;
          _isBatteryOptIgnored = battery;
        });
      }
    } on PlatformException catch (e) {
      log("Failed to check permissions: ${e.message}");
    }
  }

  Future<void> _openAccessibilitySettings() async {
    try {
      await _blockerChannel.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      log("Failed to open accessibility settings: ${e.message}");
    }
  }

  Future<void> _requestBatteryOptExemption() async {
    try {
      await _blockerChannel.invokeMethod('requestBatteryOptExemption');
    } on PlatformException catch (e) {
      log("Failed to request battery opt exemption: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final needsSetup = !_isAccessibilityEnabled;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text("Just Think"),
        actions: [
          ThemeColorSwitch(),
          ThemeModeSwitch(),
        ],
      ),
      body: Column(
        children: [
          // Permissions banner
          if (needsSetup)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.errorContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Setup Required',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _PermissionTile(
                    icon: Icons.accessibility_new,
                    label: 'Accessibility Service',
                    enabled: _isAccessibilityEnabled,
                    onTap: _openAccessibilitySettings,
                  ),
                  _PermissionTile(
                    icon: Icons.battery_saver,
                    label: 'Battery Optimization',
                    enabled: _isBatteryOptIgnored,
                    onTap: _requestBatteryOptExemption,
                  ),
                ],
              ),
            ),
          // App list
          const Expanded(child: SelectedAppsWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Select apps",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AllAppsWidget();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _PermissionTile({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        enabled ? Icons.check_circle : Icons.warning_rounded,
        color: enabled ? theme.colorScheme.primary : theme.colorScheme.error,
      ),
      title: Text(label),
      trailing: enabled
          ? null
          : TextButton(
              onPressed: onTap,
              child: const Text('Enable'),
            ),
      onTap: enabled ? null : onTap,
    );
  }
}
