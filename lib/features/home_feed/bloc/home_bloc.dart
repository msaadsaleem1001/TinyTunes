import 'dart:async';
import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
import '../../../Data/Response/status.dart';
import '../../../Models/videos_model/video_model.dart';
import '../../../Network Connectivity/check_internet.dart';
import '../../../Repository/Supabase Repository/supabase_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SupabaseRepository repository = SupabaseRepository();
  List<VideoModel> feedList = [];
  List<VideoModel> recommendedList = [];
  bool isFirstScreen = true;
  Status status = Status.LOADING;
  String errorMsg = '';

  HomeBloc() : super(const HomeState()) {
    on<GetVideos>(_getVideosEvent);
    on<OnScreenChange>(_onScreenChange);
    on<ShuffleList>(_shuffleList);
    on<CreateRecommendedList>(_createRecommendedList);
  }

  void _createRecommendedList(CreateRecommendedList event, Emitter<HomeState> emit) async{
    recommendedList.clear();
    List<VideoModel> preferredList = [];
    List<VideoModel> nonPreferredList = [];
    status = Status.LOADING;
    await Future.delayed(Duration.zero, ()=> emit(state.copyWith(status: status)));
    for(var video in feedList){
      if(video.channelName == event.video.channelName){
        preferredList.add(video);
      }else{
        nonPreferredList.add(video);
      }
    }
    recommendedList = [...preferredList, ...nonPreferredList];
    await Future.delayed(Duration.zero, () {
      status = Status.COMPLETED;
      emit(state.copyWith(recommendedList: recommendedList, status: status));
    });
  }

  void _shuffleList(ShuffleList event, Emitter<HomeState> emit) async{
    status = Status.LOADING;
    await Future.delayed(Duration.zero, ()=> emit(state.copyWith(status: status)));
    await Future.delayed(Duration.zero, () {
      feedList.shuffle();
      status = Status.COMPLETED;
      emit(state.copyWith(feedList: feedList, status: status));
    });
  }

  void _onScreenChange(OnScreenChange event, Emitter<HomeState> emit) {
    isFirstScreen = event.isFirstScreen;
    emit(state.copyWith(isFirstScreen: isFirstScreen));
  }

  void _getVideosEvent(GetVideos event, Emitter<HomeState> emit) async {
    status = Status.LOADING;
    emit(state.copyWith(status: status));
    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        feedList.clear();
        feedList = await repository.getVideos();
        status = Status.COMPLETED;
        feedList.shuffle();
        feedList.shuffle();
        feedList.shuffle();
        emit(state.copyWith(status: status, feedList: feedList));
      } catch (e) {
        status = Status.ERROR;
        // errorMsg = e.toString().substring(e.toString().indexOf('[') + 1, e.toString().indexOf(']'));
        // debugPrint('Error is: ${e.toString()}');
        errorMsg = e.toString();
        emit(state.copyWith(
          status: status,
          errorMsg: errorMsg,
        ));
        // print('Error Msg: ${e.toString()}');
      }
    } else {
      status = Status.ERROR;
      errorMsg = 'Internet connection error!\nMake sure your device has internet access.';
      emit(state.copyWith(
        status: Status.ERROR,
        errorMsg: errorMsg,
      ));
    }
  }
}
