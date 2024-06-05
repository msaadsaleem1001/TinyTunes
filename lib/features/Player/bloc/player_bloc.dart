import 'package:bloc/bloc.dart';
import 'package:tiny_tunes/features/Player/bloc/player_event.dart';
import 'package:tiny_tunes/features/Player/bloc/player_state.dart';

class AppPlayerBloc extends Bloc<AppPlayerEvent, AppPlayerState> {

  bool isFullScreen = false;


  AppPlayerBloc() : super(const AppPlayerState()) {
    on<OnFullScreenMode>(_onFullScreenMode);
  }

  void _onFullScreenMode(OnFullScreenMode event, Emitter<AppPlayerState> emit) {
    isFullScreen = event.isFullScreen;
    emit(state.copyWith(
      isFullScreen: isFullScreen,
    ));
  }


}
