import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
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

class OnChangeBarView extends HomeEvent {
  final int bottomBarIndex;

  const OnChangeBarView(
      {required this.bottomBarIndex});

  @override
  List<Object?> get props => [bottomBarIndex];
}

class SaveShortsIndex extends HomeEvent {
  final int shortsIndex;

  const SaveShortsIndex(
      {required this.shortsIndex});

  @override
  List<Object?> get props => [shortsIndex];
}
