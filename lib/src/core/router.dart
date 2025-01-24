import 'package:go_router/go_router.dart';
import 'package:just_think/main.dart';
import 'package:just_think/src/views/screens/foreground_app_screen.dart';
import 'package:just_think/src/views/screens/home_screen.dart';
import 'package:just_think/src/views/screens/overlay_screen.dart';

final appRouter = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ForegroundAppScreen(),
    ),
    // create a go router for the overlay screen
    GoRoute(path: '/overlay', builder: (context, state) => OverlayScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);