import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_think/src/models/blocked_app.dart';

class BlockedAppController extends Notifier<BlockedApp?> {
  @override
  BlockedApp? build() {
    return null;
  }

  void setBlockedApp(String packageName, String appName) {
    state = BlockedApp(packageName: packageName, appName: appName);
  }

  void removeBlockedApp() {
    state = null;
  }
}

final blockedAppController =
    NotifierProvider<BlockedAppController, BlockedApp?>(() {
  return BlockedAppController();
});
