import 'package:TinyTunes/Data/Response/status.dart';
import 'package:TinyTunes/features/Player/bloc/player_event.dart';
import 'package:TinyTunes/features/Player/bloc/player_state.dart';
import 'package:bloc/bloc.dart';

class AppPlayerBloc extends Bloc<AppPlayerEvent, AppPlayerState> {

  bool isFullScreen = false;
  Status status = Status.LOADING;
  String currentVideoId = '';

  AppPlayerBloc() : super(const AppPlayerState()) {
    on<OnFullScreenMode>(_onFullScreenMode);
    on<InitializePlayerScreen>(_initializePlayerScreen);
    on<OnVideoChange>(_onVideoChange);
  }

  void _onVideoChange(OnVideoChange event, Emitter<AppPlayerState> emit) async{
    status = Status.LOADING;
    await Future.delayed(Duration.zero, () => emit(state.copyWith(status: status)));
    status = Status.COMPLETED;
    currentVideoId = event.currentVideoId;
    await Future.delayed(const Duration(milliseconds: 600), () => emit(state.copyWith(
      status: status,
        currentVideoId: currentVideoId
    )));
  }

  void _initializePlayerScreen(InitializePlayerScreen event, Emitter<AppPlayerState> emit) async{
    currentVideoId = event.currentVideoId;
    status = Status.COMPLETED;
    await Future.delayed(const Duration(milliseconds: 600), () =>
        emit(state.copyWith(currentVideoId: currentVideoId, status: status))
    );
  }

  void _onFullScreenMode(OnFullScreenMode event, Emitter<AppPlayerState> emit) {
    isFullScreen = !isFullScreen;
    emit(state.copyWith(
      isFullScreen: isFullScreen,
    ));
  }


}
