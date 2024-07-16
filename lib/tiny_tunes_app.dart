import 'package:TinyTunes/features/confirm/bloc/confirm_bloc.dart';
import 'package:TinyTunes/features/setting/bloc/setting_bloc.dart';
import 'package:TinyTunes/features/splash/bloc/splash_bloc.dart';
import 'package:TinyTunes/res/routes/app_route_configuration.dart';
import 'package:TinyTunes/res/theme_data/theme_data.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/Player/bloc/player_bloc.dart';
import 'features/home_feed/bloc/home_bloc.dart';

class TinyTunesApp extends StatefulWidget {
  final AudioHandler audioHandler;
  const TinyTunesApp({super.key, required this.audioHandler});

  @override
  State<TinyTunesApp> createState() => _TinyTunesAppState();
}

class _TinyTunesAppState extends State<TinyTunesApp> with WidgetsBindingObserver, RouteAware{
  late final GoRouter _router;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _router = AppRoutes.routes(widget.audioHandler);
    widget.audioHandler.play();
    super.initState();
  }

  @override
  void dispose() {
    widget.audioHandler.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // debugPrint('App Exited');
      await widget.audioHandler.pause();
    } else if (state == AppLifecycleState.paused) {
      // debugPrint('App In Background');
      await widget.audioHandler.pause();
    } else if (state == AppLifecycleState.resumed) {
      // debugPrint('App Resumed');
      await widget.audioHandler.play();
    } else {
      // debugPrint('State: ${state.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (_) => HomeBloc()),
          BlocProvider(create: (_) => AppPlayerBloc()),
          BlocProvider(create: (_) => ConfirmBloc()),
          BlocProvider(create: (_) => SettingBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TinyTunes',
          theme: AppThemeData.light,
          darkTheme: AppThemeData.dark,
          themeMode: ThemeMode.dark,
          routerConfig: _router,
        )
    );
  }
}


