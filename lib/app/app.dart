import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/app/router/router_config.dart';
import 'package:mimine/common/styles/app_theme.dart';
import 'package:mimine/core/core_di/core_locator.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SplashCubit>(create: (_) => getIt<SplashCubit>()),
          BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: routerConfig,
          // builder: (context, child) => LifecycleWatcher(child: child),
        ));
  }
}
