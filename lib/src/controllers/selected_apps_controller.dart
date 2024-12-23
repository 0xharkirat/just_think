import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:isar/isar.dart';
import 'package:just_think/src/models/app_info_wrapper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:installed_apps/app_info.dart';

class SelectedAppsController extends AsyncNotifier<Map<String, AppInfo>> {
  late Isar _isar;
  @override
  Future<Map<String, AppInfo>> build() async {
    _isar = await ref.read(isarProvider.future);
    return await _loadAndValidateFromStorage();
  }

  // create a refresh function
  // use try await

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await _loadAndValidateFromStorage());
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  /// Add an app to the selected list and save to Isar
  Future<void> selectApp(AppInfo app, String key) async {
    final currentState = state.asData?.value ?? {};
    final updatedState = {...currentState, key: app};
    state = AsyncValue.data(updatedState);

    final wrapper = AppInfoWrapper.fromAppInfo(app);
    await _isar.writeTxn(() async {
      await _isar.appInfoWrappers.put(wrapper);
    });
  }

  /// Remove an app from the selected list and save to Isar
  Future<void> deselectApp(String key) async {
    final currentState = state.asData?.value ?? {};
    final updatedState = {...currentState}..remove(key);
    state = AsyncValue.data(updatedState);

    await _isar.writeTxn(() async {
      final wrapper =
          await _isar.appInfoWrappers.filter().keyEqualTo(key).findFirst();
      if (wrapper != null) {
        await _isar.appInfoWrappers.delete(wrapper.id);
      }
    });
  }

  /// Toggle an app in the selected list and save to Isar
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

  /// Load selected apps from Isar and validate them
  Future<Map<String, AppInfo>> _loadAndValidateFromStorage() async {
    final storedWrappers = await _isar.appInfoWrappers.where().findAll();
    final validatedApps = <String, AppInfo>{};

    for (var wrapper in storedWrappers) {
      log("wrapper: $wrapper");
      final app = wrapper.toAppInfo();
      final key = "${app.name},${app.packageName}";
      final isInstalled = await InstalledApps.isAppInstalled(app.packageName);
      if (isInstalled == true) {
        validatedApps[key] = app;
      } else {
        await _isar.writeTxn(() async {
          await _isar.appInfoWrappers.delete(wrapper.id);
        });
      }
    }

    return validatedApps;
  }
}

final selectedAppsController =
    AsyncNotifierProvider<SelectedAppsController, Map<String, AppInfo>>(
  () => SelectedAppsController(),
);

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([AppInfoWrapperSchema], directory: dir.path);
});
