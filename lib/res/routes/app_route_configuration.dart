import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/Error/error page route screen/error_screen.dart';
import '../../features/Player/UI/video_player.dart';
import '../../features/Shorts format Scroller/Shorts Args/shorts_args.dart';
import '../../features/Shorts format Scroller/UI/short_format_scroller.dart';
import '../../features/home_feed/ui/home_view.dart';
import 'app_route_constants.dart';

class AppRoutes {
  static final router = GoRouter(
      routes: [
        GoRoute(
            name: AppRouteConstants.homeRoute,
            path: '/',
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomeView());
            }),
        GoRoute(
            name: AppRouteConstants.playerRoute,
            path: '/player/:url',
            pageBuilder: (context, state) {
              return MaterialPage(
                  child: VideoPlayerClass(
                currentUrl: state.pathParameters['url']!,
              ));
            }),
        GoRoute(
            name: AppRouteConstants.shorts,
            path: '/shorts',
            pageBuilder: (context, state) {
              ShortsArgs shortsArgs = state.extra as ShortsArgs;
              return MaterialPage(child: ShortFormatScroller(shortsArgs: shortsArgs));
            }),
      ],
      errorPageBuilder: (context, state) {
        return const MaterialPage(child: ErrorRoute());
      });
}
