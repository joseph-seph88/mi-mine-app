import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:mimine/features/auth/presentation/pages/login_page.dart';
import 'package:mimine/features/community/community_page.dart';
import 'package:mimine/features/home/home_page.dart';
import 'package:mimine/features/map/map_page.dart';
import 'package:mimine/features/shell/shell_page.dart';
import 'package:mimine/features/splash/presentation/pages/error_page.dart';
import 'package:mimine/features/user/presentation/pages/profile_page.dart';
import 'package:mimine/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mimine/features/splash/presentation/pages/splash_page.dart';

final ShellRoute shellRoutes = ShellRoute(
  builder: (context, state, child) => ShellPage(child: child),
  routes: [
    GoRoute(
      path: RouterPath.home,
      name: RouterName.home,
      pageBuilder: (context, state) => NoTransitionPage(
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: RouterPath.map,
      name: RouterName.map,
      pageBuilder: (context, state) => NoTransitionPage(
        child: MapPage(),
      ),
    ),
    GoRoute(
      path: RouterPath.community,
      name: RouterName.community,
      pageBuilder: (context, state) => NoTransitionPage(
        child: CommunityPage(),
      ),
    ),
    GoRoute(
      path: RouterPath.profile,
      name: RouterName.profile,
      pageBuilder: (context, state) => NoTransitionPage(
        child: ProfilePage(),
      ),
    ),
  ],
);

final List<RouteBase> routerRoutes = [
  GoRoute(
    path: RouterPath.splash,
    name: RouterName.splash,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: RouterPath.error,
    name: RouterName.error,
    builder: (context, state) => ErrorPage(),
  ),
  GoRoute(
    path: RouterPath.login,
    name: RouterName.login,
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: RouterPath.signUp,
    name: RouterName.signUp,
    builder: (context, state) => SignUpPage(),
  ),
  GoRoute(
    path: RouterPath.forgotPassword,
    name: RouterName.forgotPassword,
    builder: (context, state) => ForgotPasswordPage(),
  ),
  shellRoutes,
];
