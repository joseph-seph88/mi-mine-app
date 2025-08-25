import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/app/router/router_routes.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: RouterPath.splash,
  routes: routerRoutes,
  // redirect: (context, state) {
  //   final authState = context.read<LoginCubit>().state;

  //   // 로그인 성공 상태가 아니고, 로그인/회원가입/스플래시 페이지가 아닌 경우 로그인으로 리다이렉트
  //   if (authState.status != FormzSubmissionStatus.success &&
  //       state.uri.toString() != RouterPath.login &&
  //       state.uri.toString() != RouterPath.signUp &&
  //       state.uri.toString() != RouterPath.splash) {
  //     debugPrint(
  //         "[ROUTING_INFO] Redirecting to login: ${state.uri.toString()} // ${authState.status}");
  //     return RouterPath.login;
  //   }

  //   // 로그인 성공 상태이고 로그인/회원가입 페이지에 있는 경우 메인으로 리다이렉트
  //   if (authState.status == FormzSubmissionStatus.success &&
  //       (state.uri.toString() == RouterPath.login ||
  //           state.uri.toString() == RouterPath.signUp)) {
  //     debugPrint("[ROUTING_INFO] Redirecting to main after login");
  //     return RouterPath.main;
  //   }

  //   // 강제 로그아웃 상태이고 로그인/회원가입/스플래시 페이지가 아닌 경우 로그인으로 리다이렉트
  //   if (authState.status == FormzSubmissionStatus.initial &&
  //       authState.userInfo == null &&
  //       state.uri.toString() != RouterPath.login &&
  //       state.uri.toString() != RouterPath.signUp &&
  //       state.uri.toString() != RouterPath.splash) {
  //     debugPrint("[ROUTING_INFO] Redirecting to login after force logout");
  //     return RouterPath.login;
  //   }

  //   return null;
  // },
  // errorBuilder: (context, state) => Scaffold(
  //   body: Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Icon(Icons.error_outline, size: 64, color: Colors.red),
  //         const SizedBox(height: 16),
  //         Text(
  //           '페이지를 찾을 수 없습니다',
  //           style: Theme.of(context).textTheme.headlineSmall,
  //         ),
  //         const SizedBox(height: 8),
  //         Text(
  //           '요청하신 페이지: ${state.uri}',
  //           style: Theme.of(context).textTheme.bodyMedium,
  //         ),
  //         const SizedBox(height: 16),
  //         ElevatedButton(
  //           onPressed: () => context.go(RouterPath.main),
  //           child: const Text('홈으로 돌아가기'),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
);
