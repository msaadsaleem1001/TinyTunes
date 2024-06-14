import 'package:TinyTunes/features/confirm/bloc/confirm_bloc.dart';
import 'package:TinyTunes/features/setting/bloc/setting_bloc.dart';
import 'package:TinyTunes/features/splash/bloc/splash_bloc.dart';
import 'package:TinyTunes/res/routes/app_route_configuration.dart';
import 'package:TinyTunes/res/theme_data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/Player/bloc/player_bloc.dart';
import 'features/home_feed/bloc/home_bloc.dart';

class TinyTunes extends StatelessWidget {
  const TinyTunes({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (_) => ConfirmBloc()),
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(create: (_) => SettingBloc()),
          BlocProvider(create: (_) => AppPlayerBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TinyTunes',
          theme: AppThemeData.light,
          darkTheme: AppThemeData.dark,
          themeMode: ThemeMode.dark,
          routerConfig: AppRoutes.router,
        )
    );
  }
}
