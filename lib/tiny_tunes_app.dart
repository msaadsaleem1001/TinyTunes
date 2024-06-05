import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny_tunes/res/routes/app_route_configuration.dart';
import 'package:tiny_tunes/res/theme_data/theme_data.dart';
import 'features/Player/bloc/player_bloc.dart';
import 'features/Shorts format Scroller/bloc/short_bloc.dart';
import 'features/home_feed/bloc/home_bloc.dart';

class TinyTunes extends StatelessWidget {
  const TinyTunes({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(create: (_) => AppPlayerBloc()),
          BlocProvider(create: (_) => ShortsBloc()),
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
