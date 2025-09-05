import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/app/router/router_config.dart';
import 'package:mimine/common/theme/app_theme.dart';
import 'package:mimine/common/widgets/lifecycle_watcher.dart';
import 'package:mimine/core/core_di/core_locator.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_cubit.dart';
import 'package:mimine/features/splash/presentation/cubits/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => getIt<SplashCubit>()),
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider<ShellCubit>(create: (_) => getIt<ShellCubit>()),
        BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
        BlocProvider<AdCubit>(create: (_) => getIt<AdCubit>()),
      ],
      child: LifecycleWatcher(
          child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: routerConfig,
      )),
    );
  }
}
