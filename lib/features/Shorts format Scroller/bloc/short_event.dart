
import 'package:equatable/equatable.dart';

abstract class ShortsEvent extends Equatable {

  const ShortsEvent();

  @override
  List<Object?> get props => [];

}

class OnChangeScreenMode extends ShortsEvent{

  final bool isFullScreen;

  const OnChangeScreenMode({required this.isFullScreen});

  @override
  List<Object?> get props => [isFullScreen];

}


class ListInitialization extends ShortsEvent{

  final List<String> urls;

  const ListInitialization({required this.urls});

  @override
  List<Object?> get props => [urls];

}
