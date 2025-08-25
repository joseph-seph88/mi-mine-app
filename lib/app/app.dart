import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/app/router/router_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final appConfig = getIt<AppConfig>();

    return MultiBlocProvider(
        providers: [
          // BlocProvider<LoginCubit>(
          //   create: (_) => getIt<LoginCubit>(),
          // ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          routerConfig: routerConfig,
          // builder: (context, child) => LifecycleWatcher(child: child),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MyApp extends StatelessWidget {
//   final AppConfig appConfig;

//   const MyApp({super.key, required this.appConfig});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarIconBrightness: Brightness.dark,
//     ));

//     return MaterialApp.router(
//       debugShowCheckedModeBanner: appConfig.envConfig.isDevelopment,
//       routerConfig: routerConfig,
//       theme: AppTheme.lightTheme,
//     );
//   }
// }
