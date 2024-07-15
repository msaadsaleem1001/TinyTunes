
import 'package:TinyTunes/Data/Response/status.dart';
import 'package:equatable/equatable.dart';

class AppPlayerState extends Equatable {

  final bool isFullScreen;
  final String currentUrl;
  final Status status;

  const AppPlayerState({
    this.isFullScreen = false,
    this.currentUrl = '',
    this.status = Status.LOADING
  });

  AppPlayerState copyWith({bool? isFullScreen, String? currentUrl, Status? status}){
    return AppPlayerState(
      isFullScreen: isFullScreen ?? this.isFullScreen,
      currentUrl: currentUrl ?? this.currentUrl,
      status: status ?? this.status
    );
  }


  @override
  List<Object?> get props => [isFullScreen, currentUrl, status];
}
