import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {

  const LoadingEvent();

  @override
  List<Object?> get props => [];

}

class OnLoading extends LoadingEvent{

  final bool isDim;

  const OnLoading({required this.isDim});

  @override
  List<Object?> get props => [isDim];

}
