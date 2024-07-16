
import 'package:equatable/equatable.dart';

abstract class AppPlayerEvent extends Equatable {

  const AppPlayerEvent();

  @override
  List<Object?> get props => [];

}

class OnVideoChange extends AppPlayerEvent{
  final String currentVideoId;

  const OnVideoChange({required this.currentVideoId});

  @override
  List<Object?> get props => [currentVideoId];
}

class InitializePlayerScreen extends AppPlayerEvent{

  final String currentVideoId;

  const InitializePlayerScreen({required this.currentVideoId});

  @override
  List<Object?> get props => [currentVideoId];

}

class OnFullScreenMode extends AppPlayerEvent{

  const OnFullScreenMode();

  @override
  List<Object?> get props => [];

}
