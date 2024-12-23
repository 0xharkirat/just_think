import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';


class InstalledAppsController extends AsyncNotifier<Map<String, AppInfo>> {
  @override
  Future<Map<String, AppInfo>> build() async {
    return fetchApps();
  }

  Future<Map<String, AppInfo>> fetchApps({
    bool excludeSystemApps = true,
    bool withIcon = true,
  }) async {
    try {
      final installedApps = await InstalledApps.getInstalledApps(
        excludeSystemApps,
        withIcon,
      );

      final Map<String, AppInfo> installedAppsMap =  {
        for (final app in installedApps) app.packageName: app,
      };
      return installedAppsMap;
    } catch (error) {
      throw Exception('Failed to load apps: $error');
    }
  }

  Future<void> refreshApps() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await fetchApps());
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  Future<AppInfo> getAppInfo(String packageName) async {
    return (await InstalledApps.getAppInfo(packageName))!;
  }
}

final installedAppsController =
    AsyncNotifierProvider<InstalledAppsController, Map<String, AppInfo>>(() => InstalledAppsController());
