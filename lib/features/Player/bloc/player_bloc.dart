import 'package:TinyTunes/features/Player/bloc/player_event.dart';
import 'package:TinyTunes/features/Player/bloc/player_state.dart';
import 'package:bloc/bloc.dart';

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
