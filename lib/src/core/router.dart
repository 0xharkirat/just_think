import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/views/screens/home_screen.dart';
import 'package:just_think/src/views/screens/overlay_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouter = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final blockedApp = ref.read(blockedAppController);

      if (blockedApp != null && !state.matchedLocation.contains("/overlay")) {
        return '/overlay';
      }

      if (blockedApp == null && state.matchedLocation.contains('/overlay')) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
          path: '/overlay', builder: (context, state) => const OverlayScreen()),
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    ],
  );
});

/// Listens to [blockedAppController] and notifies GoRouter to re-evaluate redirects.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(Ref ref) {
    ref.listen(blockedAppController, (_, __) {
      notifyListeners();
    });
  }
}
