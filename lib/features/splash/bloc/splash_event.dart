
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SplashEvent extends Equatable{

  const SplashEvent();

  @override
  List<Object?> get props => [];

}

class OnSplashEvent extends SplashEvent{

  final BuildContext context;

  const OnSplashEvent({required this.context});

  @override
  List<Object?> get props => [];

}
