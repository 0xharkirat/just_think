


import 'dart:convert';
import 'package:installed_apps/app_info.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension AppInfoExtension on AppInfo {
  /// Converts an `AppInfo` instance to a JSON-serializable map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'packageName': packageName,
      'versionName': versionName,
      'versionCode': versionCode,
      'installedTimestamp': installedTimestamp,
      'icon': icon != null ? base64Encode(icon!) : null, // Encode icon to Base64
    };
  }
}

