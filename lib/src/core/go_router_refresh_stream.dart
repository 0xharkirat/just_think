import 'dart:async';

import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream, Function(dynamic event) onEvent) {
    _subscription = stream.listen((event) {
      onEvent(event); // Process the event
      notifyListeners(); // Notify the router
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}