
import 'package:TinyTunes/features/setting/bloc/setting_event.dart';
import 'package:TinyTunes/features/setting/bloc/setting_state.dart';
import 'package:bloc/bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    // on<OnSplashEvent>(_onSplashEvent);
  }

  // void _onSplashEvent(OnSplashEvent event, Emitter<SplashState> emit) {
  //   Timer(const Duration(seconds: 2), (){
  //     GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
  //   });
  // }

}