import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/app/router/router_routes.dart';
import 'package:mimine/app/router/route_guard.dart';
import 'package:mimine/features/splash/presentation/pages/error_page.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: RouterPath.splash,
  routes: routerRoutes,
  redirect: (context, state) => RouteGuard.checkAccess(context, state),
  errorBuilder: (context, state) => ErrorPage(),
);
