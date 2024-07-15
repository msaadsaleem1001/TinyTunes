
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ConfirmEvent extends Equatable{

  const ConfirmEvent();

  @override
  List<Object?> get props => [];

}

class OnSubmitEvent extends ConfirmEvent{
  final BuildContext context;

  const OnSubmitEvent({required this.context});

  @override
  List<Object?> get props => [context];

}

class OnClearEvent extends ConfirmEvent{

  const OnClearEvent();

  @override
  List<Object?> get props => [];

}

class GenerateQuestion extends ConfirmEvent{

  const GenerateQuestion();

  @override
  List<Object?> get props => [];

}

class OnUserAnswer extends ConfirmEvent{

  final int enteredValue;

  const OnUserAnswer({required this.enteredValue});

  @override
  List<Object?> get props => [enteredValue];

}

