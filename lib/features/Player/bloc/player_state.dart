
import 'package:TinyTunes/Data/Response/status.dart';
import 'package:equatable/equatable.dart';

class AppPlayerState extends Equatable {

  final bool isFullScreen;
  final String currentVideoId;
  final Status status;

  const AppPlayerState({
    this.isFullScreen = false,
    this.currentVideoId = '',
    this.status = Status.LOADING
  });

  AppPlayerState copyWith({bool? isFullScreen, String? currentVideoId, Status? status}){
    return AppPlayerState(
      isFullScreen: isFullScreen ?? this.isFullScreen,
       currentVideoId: currentVideoId ?? this.currentVideoId,
      status: status ?? this.status
    );
  }


  @override
  List<Object?> get props => [isFullScreen, currentVideoId, status];
}
