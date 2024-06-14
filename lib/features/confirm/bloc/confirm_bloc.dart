
import 'package:TinyTunes/features/confirm/bloc/confirm_event.dart';
import 'package:TinyTunes/features/confirm/bloc/confirm_state.dart';
import 'package:bloc/bloc.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {
  ConfirmBloc() : super(const ConfirmState()) {
    // on<OnSplashEvent>(_onSplashEvent);
  }

  // void _onSplashEvent(OnSplashEvent event, Emitter<SplashState> emit) {
  //   Timer(const Duration(seconds: 2), (){
  //     GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
  //   });
  // }

}