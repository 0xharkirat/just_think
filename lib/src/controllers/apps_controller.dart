import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';


class AppListController extends AsyncNotifier<List<AppInfo>> {
  @override
  Future<List<AppInfo>> build() async {
    return fetchApps();
  }

  Future<List<AppInfo>> fetchApps({
    bool excludeSystemApps = true,
    bool withIcon = true,
  }) async {
    try {
      final installedApps = await InstalledApps.getInstalledApps(
        excludeSystemApps,
        withIcon,
      );
      return installedApps;
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
}

final appListController =
    AsyncNotifierProvider<AppListController, List<AppInfo>>(() => AppListController());
