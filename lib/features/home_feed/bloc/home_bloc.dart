
import 'package:bloc/bloc.dart';
import 'package:tiny_tunes/Models/videos_modal/video_modal.dart';
import '../../../Data/Response/status.dart';
import '../../../Network Connectivity/check_internet.dart';
import '../../../Repository/Supabase Repository/supabase_repository.dart';
import '../../../res/utils/get video thumbnail/get_video_thumbnail.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  SupabaseRepository repository = SupabaseRepository();
  List<VideoModal> feedList = [];
  List<String> urlList = [];
  bool isFirstScreen = true;
  Status status = Status.LOADING;
  String errorMsg = '';
  int bottomBarIndex = 0;
  String shortsSavedIndex = '';

  HomeBloc() : super(const HomeState()) {
    on<GetVideos>(_getVideosEvent);
    on<OnScreenChange>(_onScreenChange);
    on<OnChangeBarView>(_onChangeBarView);
    on<SaveShortsIndex>(_saveShortsIndex);
  }

  void _saveShortsIndex(SaveShortsIndex event, Emitter<HomeState> emit){
    shortsSavedIndex = urlList[event.shortsIndex];
    emit(state.copyWith(shortsSavedIndex: shortsSavedIndex));
  }

  void _onChangeBarView(OnChangeBarView event, Emitter<HomeState> emit){
    bottomBarIndex = event.bottomBarIndex;
    emit(state.copyWith(bottomBarIndex: bottomBarIndex));
  }

  void _onScreenChange(OnScreenChange event, Emitter<HomeState> emit){
    isFirstScreen = event.isFirstScreen;
    emit(state.copyWith(isFirstScreen: isFirstScreen));
  }

  void _getVideosEvent(GetVideos event, Emitter<HomeState> emit) async{
    status = Status.LOADING;
    emit(state.copyWith(status: status));
    if(await CheckInternetConnection.checkInternetConnectionFunction()){
      try{
        feedList.clear();
        urlList.clear();
        feedList = await repository.getAllVideos();
        for(var video in feedList){
          urlList.add(GetVideoThumbnail.getYouTubeWatchUrl(video.url));
        }
        // print('Video List: ${feedList.length}');
        status = Status.COMPLETED;
        feedList = List.from(feedList.reversed);
        urlList = List.from(urlList.reversed);
        emit(state.copyWith(
          status: Status.COMPLETED,
          feedList: List.from(feedList),
          urlList: List.from(urlList)
        ));
      }catch(e){
        status = Status.ERROR;
        errorMsg = e.toString().substring(e.toString().indexOf('[') + 1, e.toString().indexOf(']'));
        emit(state.copyWith(
          status: status,
          errorMsg: errorMsg.toUpperCase(),
        ));
        // print('Error Msg: ${e.toString()}');
      }
    }
    else{
      status = Status.ERROR;
      errorMsg = 'Internet connection error!\nMake sure your device has internet access.';
      emit(state.copyWith(
        status: Status.ERROR,
        errorMsg: errorMsg,
      ));
    }

  }

}