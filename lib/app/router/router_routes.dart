import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/features/auth/login_page.dart';
import 'package:mimine/features/auth/sign_up_page.dart';
import 'package:mimine/features/splash/presentation/splash_page.dart';

final List<GoRoute> routerRoutes = [
  GoRoute(
    path: RouterPath.splash,
    name: RouterNames.splash,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: RouterPath.login,
    name: RouterNames.login,
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: RouterPath.signUp,
    name: RouterNames.signUp,
    builder: (context, state) => SignUpPage(),
  ),
];
