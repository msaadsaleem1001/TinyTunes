
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingEvent extends Equatable{

  const SettingEvent();

  @override
  List<Object?> get props => [];

}

class GetCategorySetting extends SettingEvent{

  const GetCategorySetting();

  @override
  List<Object?> get props => [];

}

class OnSaveEvent extends SettingEvent{
  final BuildContext context;

  const OnSaveEvent({required this.context});

  @override
  List<Object?> get props => [context];

}

class OnRadioChange extends SettingEvent{

  final String selectedVal;

  const OnRadioChange({required this.selectedVal});

  @override
  List<Object?> get props => [selectedVal];
}

class OnChangeCheckBox extends SettingEvent{

  final bool value;
  final int index;

  const OnChangeCheckBox({required this.index, required this.value});

  @override
  List<Object?> get props => [value, index];

}

