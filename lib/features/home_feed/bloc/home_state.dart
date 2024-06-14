import 'package:equatable/equatable.dart';
import '../../../Data/Response/status.dart';
import '../../../Models/videos_modal/video_modal.dart';

class HomeState extends Equatable {
  final List<VideoModal> feedList;
  final List<String> urlList;
  final bool isFirstScreen;
  final Status status;
  final String errorMsg;
  final int bottomBarIndex;
  final String shortsSavedIndex;

  const HomeState({
    this.isFirstScreen = true,
    this.feedList = const [],
    this.urlList = const [],
    this.status = Status.LOADING,
    this.errorMsg = '',
    this.bottomBarIndex = 0,
    this.shortsSavedIndex = '',
  });

  HomeState copyWith(
      {List<VideoModal>? feedList,
      List<String>? urlList,
      bool? isFirstScreen,
      Status? status,
      String? errorMsg,
      int? bottomBarIndex,
      String? shortsSavedIndex}) {
    return HomeState(
        feedList: feedList ?? this.feedList,
        urlList: urlList ?? this.urlList,
        isFirstScreen: isFirstScreen ?? this.isFirstScreen,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        bottomBarIndex: bottomBarIndex ?? this.bottomBarIndex,
        shortsSavedIndex: shortsSavedIndex ?? this.shortsSavedIndex);
  }

  @override
  List<Object?> get props => [
        feedList,
        urlList,
        isFirstScreen,
        status,
        errorMsg,
        bottomBarIndex,
        shortsSavedIndex
      ];
}
