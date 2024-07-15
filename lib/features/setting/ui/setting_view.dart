import 'package:TinyTunes/features/setting/bloc/setting_bloc.dart';
import 'package:TinyTunes/features/setting/bloc/setting_event.dart';
import 'package:TinyTunes/features/setting/bloc/setting_state.dart';
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/app_constants/app_constants.dart';
import 'package:TinyTunes/res/app_text_styles/text_styles.dart';
import 'package:TinyTunes/res/components/Custom%20AppBar/custom_appbar.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingView extends StatefulWidget {
  final AudioHandler audioHandler;
  const SettingView({super.key, required this.audioHandler});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late SettingBloc settingBloc;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
    settingBloc = SettingBloc();
    settingBloc.add(const GetCategorySetting());
    widget.audioHandler.pause();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    settingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    // final height = MediaQuery.sizeOf(context).height * 1;
    return BackButtonListener(
      onBackButtonPressed: () async{
        settingBloc.add(OnSaveEvent(context: context));
        return true;
      },
      child: BlocProvider(
        create: (context) => settingBloc,
        child: Scaffold(
            appBar: TinyTunesAppBars.settingsAppBar(context, settingBloc),
            body: SingleChildScrollView(
              primary: false,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: width,
                    height: 200,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration:
                    const BoxDecoration(color: AppColors.settingFirstBlock),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Choose Between',
                            style: AppTextStyles.subTitleStyle()),
                        Flexible(
                            child: BlocBuilder<SettingBloc, SettingState>(
                              buildWhen: (p, c) => p.radioGroupVal != c.radioGroupVal,
                              builder: (context, state) {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: state.options.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: 75,
                                      child: Center(
                                        child: ListTile(
                                          enableFeedback: false,
                                          onTap: () {
                                            settingBloc.add(OnRadioChange(
                                                selectedVal: state.options[index]));
                                          },
                                          title: Text(state.options[index],
                                              style: AppTextStyles.titleStyle()),
                                          trailing: Radio<String>(
                                            activeColor: AppColors.appWhite,
                                            value: state.options[index],
                                            groupValue: state.radioGroupVal,
                                            onChanged: (String? value) {
                                              settingBloc.add(
                                                  OnRadioChange(selectedVal: value!));
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, val) {
                                    return const Opacity(
                                        opacity: .5,
                                        child: Divider(
                                          thickness: 1,
                                          height: 2,
                                          color: AppColors.appWhite,
                                        ));
                                  },
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: 450,
                    padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration:
                    const BoxDecoration(color: AppColors.settingFirstBlock),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Select Categories',
                            style: AppTextStyles.subTitleStyle()),
                        Flexible(
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                primary: false,
                                itemCount: AppConstants.categoryList.length,
                                itemBuilder: (context, index) {
                                  return BlocBuilder<SettingBloc, SettingState>(
                                    builder: (context, state) {
                                      return CheckboxListTile(
                                        fillColor: WidgetStateColor.transparent,
                                        enableFeedback: false,
                                        splashRadius: 20,
                                        checkColor: AppColors.appWhite,
                                        enabled: state.radioGroupVal == 'Default'
                                            ? false
                                            : true,
                                        title: Text(
                                            AppConstants.categoryList[index]),
                                        value: state.radioGroupVal == 'Default'
                                            ? true
                                            : state.checkBoxesValueList[index],
                                        onChanged: (bool? value) {
                                          settingBloc.add(OnChangeCheckBox(
                                              index: index, value: value!));
                                          setState(() {});
                                        },
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, separatedIndex) {
                                  return const Opacity(
                                      opacity: .5,
                                      child: Divider(
                                        thickness: 1,
                                        height: 2,
                                        color: AppColors.appWhite,
                                      ));
                                }))
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
