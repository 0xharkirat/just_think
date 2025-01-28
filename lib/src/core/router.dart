import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_think/src/controllers/blocked_app_controller.dart';
import 'package:just_think/src/views/screens/home_screen.dart';
import 'package:just_think/src/views/screens/overlay_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouter = Provider<GoRouter>((ref) {
  final blockedApp = ref.watch(blockedAppController);

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    redirect: (context, state) {
      // Redirect to overlay if there's a blocked app
      if (blockedApp != null && !state.matchedLocation.contains("/overlay")) {
        return '/overlay';
      }

      // Redirect to home if no app is blocked
      if (blockedApp == null && state.matchedLocation.contains('/overlay')) {
        return '/';
      }

      return null; // No redirection needed
    },
    routes: [
      // create a go router for the overlay screen
      GoRoute(path: '/overlay', builder: (context, state) => OverlayScreen()),
      GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    ],
  );
});
