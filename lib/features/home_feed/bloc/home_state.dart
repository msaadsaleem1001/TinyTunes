import 'package:equatable/equatable.dart';
import '../../../Data/Response/status.dart';
import '../../../Models/videos_model/video_model.dart';

class HomeState extends Equatable {
  final List<VideoModel> feedList;
  final List<VideoModel> recommendedList;
  final bool isFirstScreen;
  final Status status;
  final String errorMsg;

  const HomeState({
    this.isFirstScreen = true,
    this.feedList = const [],
    this.recommendedList = const [],
    this.status = Status.LOADING,
    this.errorMsg = ''
  });

  HomeState copyWith(
      {List<VideoModel>? feedList,
      List<VideoModel>? recommendedList,
      bool? isFirstScreen,
      Status? status,
      String? errorMsg}) {
    return HomeState(
        feedList: feedList ?? this.feedList,
        recommendedList: recommendedList ?? this.recommendedList,
        isFirstScreen: isFirstScreen ?? this.isFirstScreen,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [
        feedList,
        isFirstScreen,
        status,
        errorMsg,
        recommendedList
      ];
}
