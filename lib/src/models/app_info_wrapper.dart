import 'dart:convert';

import 'package:installed_apps/app_info.dart';

class AppInfoWrapper {
  final String packageName;
  final String appName;
  bool shouldBlock;

  AppInfoWrapper({
    required this.packageName,
    required this.appName,
    this.shouldBlock = true,
  });

  factory AppInfoWrapper.fromAppInfo(AppInfo appInfo) {
    return AppInfoWrapper(
      packageName: appInfo.packageName,
      appName: appInfo.name,
    );
  }

  factory AppInfoWrapper.fromJson(Map<String, dynamic> json) {
    return AppInfoWrapper(
      packageName: json['packageName'] as String,
      appName: json['appName'] as String,
      shouldBlock: json['shouldBlock'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageName': packageName,
      'appName': appName,
      'shouldBlock': shouldBlock,
    };
  }

  static List<AppInfoWrapper> decodeList(String jsonString) {
    final List<dynamic> list = jsonDecode(jsonString);
    return list
        .map((e) => AppInfoWrapper.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String encodeList(List<AppInfoWrapper> wrappers) {
    return jsonEncode(wrappers.map((w) => w.toJson()).toList());
  }

  @override
  String toString() {
    return 'AppInfoWrapper{packageName: $packageName, shouldBlock: $shouldBlock, appName: $appName}';
  }
}
