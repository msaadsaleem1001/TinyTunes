
import 'package:equatable/equatable.dart';

abstract class AppPlayerEvent extends Equatable {

  const AppPlayerEvent();

  @override
  List<Object?> get props => [];

}


class OnFullScreenMode extends AppPlayerEvent{

  final bool isFullScreen;

  const OnFullScreenMode({required this.isFullScreen});

  @override
  List<Object?> get props => [isFullScreen];

}
