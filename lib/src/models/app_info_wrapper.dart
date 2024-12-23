import 'dart:convert';
import 'package:installed_apps/app_info.dart';
import 'package:isar/isar.dart';

part 'app_info_wrapper.g.dart';

@collection
class AppInfoWrapper {
  Id id = Isar.autoIncrement; // Primary key
  late String key;
  late String name;
  late String packageName;
  late String versionName;
  late int versionCode;
  late int installedTimestamp;
  @enumerated
  late BuiltWith builtWith;

  // Store icon as a Base64-encoded string
  String? iconBase64;

  AppInfoWrapper();

  /// Convert from `AppInfo`
  AppInfoWrapper.fromAppInfo(AppInfo appInfo) {
    name = appInfo.name;
    packageName = appInfo.packageName;
    versionName = appInfo.versionName;
    versionCode = appInfo.versionCode;
    installedTimestamp = appInfo.installedTimestamp;
    iconBase64 = appInfo.icon != null ? base64Encode(appInfo.icon!) : null;
    builtWith = appInfo.builtWith;
    key = "${appInfo.name},${appInfo.packageName}";
  }

  /// Convert to `AppInfo`
  AppInfo toAppInfo() {
    return AppInfo(
      name: name,
      packageName: packageName,
      versionName: versionName,
      versionCode: versionCode,
      installedTimestamp: installedTimestamp,
      icon: iconBase64 != null ? base64Decode(iconBase64!) : null,
      builtWith: builtWith,
    );
  }

  @override
  String toString() {
    return 'AppInfoWrapper{key: $key, name: $name, packageName: $packageName, versionName: $versionName, versionCode: $versionCode, installedTimestamp: $installedTimestamp, builtWith: $builtWith}';
  }
}
