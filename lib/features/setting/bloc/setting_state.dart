
import 'package:equatable/equatable.dart';

class SettingState extends Equatable{

  final List<bool> checkBoxesValueList;
  final List<String> options;
  final String radioGroupVal;

  const SettingState({
    this.checkBoxesValueList = const [false, false, false, false, false, false, false],
    this.options = const ['Default', 'Custom'],
    this.radioGroupVal = 'Default',
  });

  SettingState copyWith({String? radioGroupVal, List<bool>? checkBoxesValueList}){
    return SettingState(
      checkBoxesValueList: checkBoxesValueList ?? this.checkBoxesValueList,
      options: options,
      radioGroupVal: radioGroupVal ?? this.radioGroupVal,
    );
  }

  @override
  List<Object?> get props => [checkBoxesValueList, options, radioGroupVal];

}