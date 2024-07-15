import 'package:TinyTunes/Models/Category%20Setting%20Model/settings_model.dart';
import 'package:TinyTunes/Repository/Settings%20Repo/settings_repo.dart';
import 'package:TinyTunes/features/setting/bloc/setting_event.dart';
import 'package:TinyTunes/features/setting/bloc/setting_state.dart';
import 'package:TinyTunes/res/app_constants/app_constants.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:TinyTunes/res/utils/Category%20List%20Management/category_management.dart';
import 'package:TinyTunes/res/utils/Dialog/confirmation_dialogbox.dart';
import 'package:TinyTunes/res/utils/toast/toast.dart';
import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {

  List<bool> checkBoxesValueList = [false, false, false, false, false, false, false];
  String radioGroupVal = 'Default';

  SettingBloc() : super(const SettingState()) {
    on<OnRadioChange>(_onRadioChange);
    on<OnChangeCheckBox>(_onChangeCheckBox);
    on<OnSaveEvent>(_onSaveEvent);
    on<GetCategorySetting>(_getCategorySettings);
  }

  void _getCategorySettings(GetCategorySetting event, Emitter<SettingState> emit) async{
    // debugPrint('get Settings called');
    SettingsModel settingsModel = CategoryDatabase.getCategoryBox();
    // debugPrint('Model type: ${settingsModel.type}');
    // debugPrint('List: ${settingsModel.categories}');
    radioGroupVal = settingsModel.type;
    if(radioGroupVal == 'Default'){
      emit(state.copyWith(
        radioGroupVal: radioGroupVal
      ));
    }else{
      checkBoxesValueList = CategoryManagement.getBoolListAgainstCategoryList(settingsModel.categories);
      emit(state.copyWith(
        checkBoxesValueList: checkBoxesValueList,
        radioGroupVal: radioGroupVal
      ));
    }
  }

  void _onSaveEvent(OnSaveEvent event, Emitter<SettingState> emit) async {
    if(radioGroupVal == 'Custom'){
      if(checkBoxesValueList.contains(true)){
        if(await AppDialogs.showSaveConfirmationDialog(event.context)){
          if(radioGroupVal == 'Custom'){
            // Custom Setting
            // debugPrint('Custom');
            List<String> newCategoriesList = CategoryManagement.getStringListFromBoolList(checkBoxesValueList);
            SettingsModel currentSetting = SettingsModel(type: radioGroupVal, categories: newCategoriesList);
            await CategoryDatabase.updateCategoryBox(currentSetting).whenComplete(() async {
              if(event.context.mounted){
                while(GoRouter.of(event.context).canPop()) {
                  event.context.pop();
                }
                GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
              }
            });
          }
          else{
            // Default Setting
            // debugPrint('Default');
            // await Future.delayed(Duration.zero, () => emit(state.copyWith(isSaving: true)));
            SettingsModel currentSetting = SettingsModel(type: radioGroupVal, categories: AppConstants.categoryList);
            await CategoryDatabase.updateCategoryBox(currentSetting).whenComplete(() async{
              // await Future.delayed(Duration.zero, () => emit(state.copyWith(isSaving: false)));
              if(event.context.mounted){
                while(GoRouter.of(event.context).canPop()) {
                  event.context.pop();
                }
                GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
              }
            });
          }
        }
        else{
          /// Nothing to do.
          // print('Cancel');
        }
      }
      else{
        AppToast.showToastForSelectCategory(context: event.context, message: 'Kindly select at-least one category');
      }
    }
    else{
      if(await AppDialogs.showSaveConfirmationDialog(event.context)){
        // Default Setting
        // debugPrint('Default');
        // await Future.delayed(Duration.zero, () => emit(state.copyWith(isSaving: true)));
        SettingsModel currentSetting = SettingsModel(type: radioGroupVal, categories: AppConstants.categoryList);
        await CategoryDatabase.updateCategoryBox(currentSetting).whenComplete(() async{
          // await Future.delayed(Duration.zero, () => emit(state.copyWith(isSaving: false)));
          if(event.context.mounted){
            while(GoRouter.of(event.context).canPop()) {
              event.context.pop();
            }
            GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.homeRoute);
          }
        });
      }
    }
  }

  void _onChangeCheckBox(OnChangeCheckBox event, Emitter<SettingState> emit){
    checkBoxesValueList.removeAt(event.index);
    checkBoxesValueList.insert(event.index, event.value);
    emit(state.copyWith(
      checkBoxesValueList: checkBoxesValueList
    ));
    // print(checkBoxesValueList);
  }

  void _onRadioChange(OnRadioChange event, Emitter<SettingState> emit) {
    radioGroupVal = event.selectedVal;
    emit(state.copyWith(
      radioGroupVal: radioGroupVal
    ));
  }

}