import 'package:bloc/bloc.dart';
import 'package:tiny_tunes/features/Shorts%20format%20Scroller/bloc/short_event.dart';
import 'package:tiny_tunes/features/Shorts%20format%20Scroller/bloc/short_state.dart';

class ShortsBloc extends Bloc<ShortsEvent, ShortsState> {

  List<String> urlList = [];
  bool isFullScreen = false;


  ShortsBloc() : super(const ShortsState()) {
    on<ListInitialization>(_initialization);
    on<OnChangeScreenMode>(_onChangeScreen);
  }

  void _onChangeScreen(OnChangeScreenMode event, Emitter<ShortsState> emit) {
    isFullScreen = event.isFullScreen;
    emit(state.copyWith(
      isFullScreenMode: isFullScreen,
    ));
  }

  void _initialization(ListInitialization event, Emitter<ShortsState> emit) {
    urlList = List.from(event.urls);
    emit(state.copyWith(
      urlList: List.from(urlList)
    ));
  }


}
