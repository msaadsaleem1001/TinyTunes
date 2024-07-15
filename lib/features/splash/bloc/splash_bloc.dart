
import 'dart:async';
import 'package:TinyTunes/features/splash/bloc/splash_event.dart';
import 'package:TinyTunes/features/splash/bloc/splash_state.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../Models/Category Setting Model/settings_model.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  String categoryBox = "categoryBox";

  SplashBloc() : super(const SplashState()) {
    on<OnSplashEvent>(_onSplashEvent);
  }

  void _onSplashEvent(OnSplashEvent event, Emitter<SplashState> emit) {
    Timer(const Duration(seconds: 2), (){
      try{
        // debugPrint('Called try');
        var box = Hive.box<SettingsModel>(categoryBox);
        // debugPrint('Values: ${box.values.single.type}');
        // debugPrint('Values: ${box.values.single.categories}');
        if(box.isEmpty){
          GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.confirm);
        }else{
          GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
        }
      }catch(e){
        // GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
        debugPrint('Catch Called: ${e.toString()}');
      }
    });
  }

}