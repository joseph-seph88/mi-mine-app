import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/events/app_events.dart';
import 'package:mimine/common/events/event_bus.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  const LifecycleWatcher({required this.child, super.key});

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  bool isFullScreenMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        final currentRoute = _getCurrentRoute();
        if (!_isAuthPage(currentRoute)) {
          eventBus.fire(AppResumedEvent());
        }
        break;
      case AppLifecycleState.paused:
        eventBus.fire(AppPausedEvent());
        break;
      case AppLifecycleState.inactive:
        eventBus.fire(AppInactiveEvent());
        break;
      case AppLifecycleState.detached:
        eventBus.fire(AppDetachedEvent());
        break;
      case AppLifecycleState.hidden:
        // iOS에서만 발생하는 상태
        break;
    }
  }

  String _getCurrentRoute() {
    final context = this.context;
    String? currentRoute;

    try {
      currentRoute = GoRouterState.of(context).uri.toString();
    } catch (e) {
      currentRoute = RouterPath.home;
    }

    return currentRoute;
  }

  bool _isAuthPage(String route) {
    return route.contains(RouterPath.login) ||
        route.contains(RouterPath.signUp) ||
        route.contains(RouterPath.splash);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
