
import 'dart:async';
import 'package:TinyTunes/features/splash/bloc/splash_event.dart';
import 'package:TinyTunes/features/splash/bloc/splash_state.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<OnSplashEvent>(_onSplashEvent);
  }

  void _onSplashEvent(OnSplashEvent event, Emitter<SplashState> emit) {
    Timer(const Duration(seconds: 2), (){
      GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
    });
  }

}