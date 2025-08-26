import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/features/auth/presentation/pages/login_page.dart';
import 'package:mimine/features/shell/shell_page.dart';
import 'package:mimine/features/splash/presentation/pages/error_page.dart';
import 'package:mimine/features/user/presentation/pages/sign_up_page.dart';
import 'package:mimine/features/splash/presentation/pages/splash_page.dart';

final List<GoRoute> routerRoutes = [
  GoRoute(
    path: RouterPath.splash,
    name: RouterName.splash,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: RouterPath.shell,
    name: RouterName.shell,
    builder: (context, state) => ShellPage(),
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

];
