import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:just_think/src/controllers/installed_apps_controller.dart';
import 'package:just_think/src/models/app_info_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:installed_apps/app_info.dart';

const _selectedAppsKey = 'selected_apps';
const _blockerChannel = 'com.hsi.harki.just_think/blocker';

class SelectedAppsController extends AsyncNotifier<Map<String, AppInfo>> {
  late SharedPreferences _prefs;

  @override
  Future<Map<String, AppInfo>> build() async {
    _prefs = await SharedPreferences.getInstance();
    return await _loadAndValidateFromStorage();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await _loadAndValidateFromStorage());
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  /// Add an app to the selected list
  Future<void> selectApp(AppInfo app, String key) async {
    final currentState = state.asData?.value ?? {};
    final updatedState = {...currentState, key: app};
    state = AsyncValue.data(updatedState);
    await _saveToStorage();
  }

  /// Remove an app from the selected list
  Future<void> deselectApp(String key) async {
    final currentState = state.asData?.value ?? {};
    final updatedState = {...currentState}..remove(key);
    state = AsyncValue.data(updatedState);
    await _saveToStorage();
  }

  /// Toggle an app in the selected list
  Future<void> toggleApp(AppInfo app, String key) async {
    final currentState = state.asData?.value ?? {};
    if (currentState.containsKey(key)) {
      await deselectApp(key);
    } else {
      await selectApp(app, key);
    }
  }

  /// Check if an app is selected
  bool isSelected(String key) {
    return state.asData?.value.containsKey(key) ?? false;
  }

  /// Temporarily unblock an app (set shouldBlock to false)
  Future<void> unblockApp(String key) async {
    log("Unblocking the app: $key");
    // The app stays selected but shouldBlock is handled via cooldown
    // in the AccessibilityService native side
  }

  /// Load selected apps from SharedPreferences and validate them
  Future<Map<String, AppInfo>> _loadAndValidateFromStorage() async {
    final jsonString = _prefs.getString(_selectedAppsKey);
    if (jsonString == null || jsonString.isEmpty) return {};

    final storedWrappers = AppInfoWrapper.decodeList(jsonString);
    final validatedApps = <String, AppInfo>{};
    final validWrappers = <AppInfoWrapper>[];

    for (var wrapper in storedWrappers) {
      log("wrapper: $wrapper");
      final isInstalled =
          await InstalledApps.isAppInstalled(wrapper.packageName);
      if (isInstalled == true) {
        validatedApps[wrapper.packageName] = await ref
            .read(installedAppsController.notifier)
            .getAppInfo(wrapper.packageName);
        validWrappers.add(wrapper);
      }
    }

    // Save back only validated apps
    if (validWrappers.length != storedWrappers.length) {
      await _prefs.setString(
          _selectedAppsKey, AppInfoWrapper.encodeList(validWrappers));
      await _syncBlockedPackagesToNative(validWrappers);
    }

    return validatedApps;
  }

  /// Save current selected apps to SharedPreferences and sync to native
  Future<void> _saveToStorage() async {
    final currentState = state.asData?.value ?? {};
    final wrappers = currentState.entries
        .map((e) => AppInfoWrapper.fromAppInfo(e.value))
        .toList();
    await _prefs.setString(
        _selectedAppsKey, AppInfoWrapper.encodeList(wrappers));
    await _syncBlockedPackagesToNative(wrappers);
  }

  /// Sync blocked package names to native AccessibilityService via MethodChannel.
  /// Uses MethodChannel so Kotlin writes a native StringSet to SharedPreferences,
  /// which the AccessibilityService can read with getStringSet().
  Future<void> _syncBlockedPackagesToNative(
      List<AppInfoWrapper> wrappers) async {
    final blockedList =
        wrappers.where((w) => w.shouldBlock).map((w) => w.packageName).toList();
    try {
      await const MethodChannel(_blockerChannel)
          .invokeMethod('syncBlockedPackages', {'packages': blockedList});
      log("Synced ${blockedList.length} blocked packages to native");
    } on PlatformException catch (e) {
      log("Failed to sync blocked packages: ${e.message}");
    }
  }
}

final selectedAppsController =
    AsyncNotifierProvider<SelectedAppsController, Map<String, AppInfo>>(
  () => SelectedAppsController(),
);
