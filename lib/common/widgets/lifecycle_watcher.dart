// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mimine/app/router/router_constants.dart';

// class LifecycleWatcher extends StatefulWidget {
//   final Widget child;
//   const LifecycleWatcher({required this.child, super.key});

//   @override
//   State<LifecycleWatcher> createState() => _LifecycleWatcherState();
// }

// class _LifecycleWatcherState extends State<LifecycleWatcher>
//     with WidgetsBindingObserver {
//   bool isFullScreenMode = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // 이벤트 버스 제거 - 필요시 직접 처리
//     switch (state) {
//       case AppLifecycleState.resumed:
//         // 앱 재진입 시 처리 (필요시)
//         break;
//       case AppLifecycleState.paused:
//         // 앱 일시정지 시 처리 (필요시)
//         break;
//       case AppLifecycleState.inactive:
//         // 앱 비활성화 시 처리 (필요시)
//         break;
//       case AppLifecycleState.detached:
//         // 앱 분리 시 처리 (필요시)
//         break;
//       case AppLifecycleState.hidden:
//         break;
//     }
//   }

//   String _getCurrentRoute() {
//     final context = this.context;
//     String? currentRoute;

//     try {
//       currentRoute = GoRouterState.of(context).uri.toString();
//     } catch (e) {
//       currentRoute = RouterPath.home;
//     }

//     return currentRoute;
//   }

//   bool _isAuthPage(String route) {
//     return route.contains(RouterPath.login) ||
//         route.contains(RouterPath.signUp);
//     // route.contains(RouterPath.splash);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
