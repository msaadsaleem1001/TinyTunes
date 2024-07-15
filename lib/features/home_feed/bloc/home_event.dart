import 'package:TinyTunes/Models/videos_model/video_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class CreateRecommendedList extends HomeEvent{

  final VideoModel video;

  const CreateRecommendedList({required this.video});

  @override
  List<Object?> get props => [video];
}

class GetVideos extends HomeEvent {
  const GetVideos();

  @override
  List<Object?> get props => [];
}

class ShuffleList extends HomeEvent {
  const ShuffleList();

  @override
  List<Object?> get props => [];
}

class OnScreenChange extends HomeEvent {
  final bool isFirstScreen;

  const OnScreenChange({required this.isFirstScreen});

  @override
  List<Object?> get props => [isFirstScreen];
}
