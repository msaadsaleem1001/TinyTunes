
import 'package:equatable/equatable.dart';

class AppPlayerState extends Equatable {

  final bool isFullScreen;
  final bool isFirstScreen;

  const AppPlayerState({
    this.isFullScreen = false,
    this.isFirstScreen = false,
  });

  AppPlayerState copyWith({bool? isFullScreen, bool? isFirstScreen}){
    return AppPlayerState(
      isFullScreen: isFullScreen ?? this.isFullScreen,
      isFirstScreen: isFirstScreen ?? this.isFirstScreen
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [isFullScreen, isFirstScreen];
}
