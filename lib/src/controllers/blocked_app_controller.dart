import 'package:flutter_riverpod/flutter_riverpod.dart';


class BlockedAppController extends Notifier<List<String>?> {
  @override
  List<String>? build() {
    return null;
  }

  void setBlockedApp(String packageName, String appName) {
    state = [packageName, appName];
  }

  void removeBlockedApp() {
    state = null;
  }
}

final blockedAppController =
    NotifierProvider<BlockedAppController, List<String>?>(() {
  return BlockedAppController();
});
