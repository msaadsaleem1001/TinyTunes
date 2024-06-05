import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tiny_tunes/res/components/Loading%20List/Loading%20Bloc/loading_event.dart';
import 'package:tiny_tunes/res/components/Loading%20List/Loading%20Bloc/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {

  bool isDim = false;

  LoadingBloc() : super(const LoadingState()) {
    on<OnLoading>(_onLoading);
  }

  void _onLoading(OnLoading event, Emitter<LoadingState> emit) {
    Timer.periodic(const Duration(milliseconds: 400), (timer){
      isDim = !isDim;
      emit(state.copyWith(isDim: isDim));
    });
  }

}
