import 'package:installed_apps/app_info.dart';
import 'package:isar/isar.dart';

part 'app_info_wrapper.g.dart';

@collection
class AppInfoWrapper {
  Id id = Isar.autoIncrement; // Primary key

  @Index(unique: true) // Ensures packageName is unique
  late String packageName;
  
  /// App name
  late String appName;

  // add a bool shouldBlock field
  bool shouldBlock = true;

  AppInfoWrapper();

  /// Convert from `AppInfo`
  AppInfoWrapper.fromAppInfo(AppInfo appInfo) {
    packageName = appInfo.packageName;
    appName = appInfo.name;
    
  }

  @override
  String toString() {
    return 'AppInfoWrapper{packageName: $packageName, shouldBlock: $shouldBlock, appName: $appName}';
  }
}
