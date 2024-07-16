import 'package:TinyTunes/features/Player/Player%20Args/player_args.dart';
import 'package:TinyTunes/features/Player/UI/player_screen.dart';
import 'package:TinyTunes/features/confirm/ui/confirm_view.dart';
import 'package:TinyTunes/features/splash/ui/splash_view.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/Error/error page route screen/error_screen.dart';
import '../../features/home_feed/ui/home_view.dart';
import '../../features/setting/ui/setting_view.dart';
import 'app_route_constants.dart';

class AppRoutes {

  static GoRouter routes(AudioHandler audioHandler) {
    return GoRouter(
        routes: [
          GoRoute(
              name: AppRouteConstants.splash,
              path: '/',
              pageBuilder: (context, state) {
                return MaterialPage(child: SplashView(audioHandler: audioHandler));
              }),
          GoRoute(
              name: AppRouteConstants.homeRoute,
              path: '/home',
              pageBuilder: (context, state) {
                return MaterialPage(child: HomeView(
                  audioHandler: audioHandler,
                ));
              }),
          GoRoute(
              name: AppRouteConstants.playerRoute,
              path: '/player',
              pageBuilder: (context, state) {
                PlayerArgs playerArgs = state.extra as PlayerArgs;
                return MaterialPage(
                    child: AppPlayerScreen(playerArgs: playerArgs, audioHandler: audioHandler));
              }),
          GoRoute(
              name: AppRouteConstants.confirm,
              path: '/confirm',
              pageBuilder: (context, state) {
                return MaterialPage(child: ConfirmView(audioHandler: audioHandler));
              }),
          GoRoute(
              name: AppRouteConstants.setting,
              path: '/setting',
              pageBuilder: (context, state) {
                return MaterialPage(child: SettingView(audioHandler: audioHandler));
              }),
        ],
        errorPageBuilder: (context, state) {
          return const MaterialPage(child: ErrorRoute());
        });
  }
}
