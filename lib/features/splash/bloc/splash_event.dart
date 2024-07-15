
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SplashEvent extends Equatable{

  const SplashEvent();

  @override
  List<Object?> get props => [];

}

class OnSplashEvent extends SplashEvent{

  final BuildContext context;
  final AudioHandler audioHandler;

  const OnSplashEvent({required this.context, required this.audioHandler});

  @override
  List<Object?> get props => [context, audioHandler];

}
