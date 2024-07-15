import 'package:TinyTunes/features/confirm/bloc/confirm_bloc.dart';
import 'package:TinyTunes/features/confirm/bloc/confirm_event.dart';
import 'package:TinyTunes/features/confirm/bloc/confirm_state.dart';
import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/app_text_styles/text_styles.dart';
import 'package:TinyTunes/res/components/Custom%20AppBar/custom_appbar.dart';
import 'package:TinyTunes/res/components/Custom%20Keyboard/custom_keyboard.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../res/utils/Dialog/confirmation_dialogbox.dart';

class ConfirmView extends StatefulWidget {
  final AudioHandler audioHandler;
  const ConfirmView({super.key, required this.audioHandler});

  @override
  State<ConfirmView> createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {
  late ConfirmBloc _confirmBloc;

  @override
  void initState() {
    super.initState();
    _confirmBloc = ConfirmBloc();
    _confirmBloc.add(const GenerateQuestion());
  }

  @override
  void dispose() {
    _confirmBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return BlocProvider(
        create: (context) => _confirmBloc,
        child: Scaffold(
            appBar: TinyTunesAppBars.confirmAppBar(context),
            extendBodyBehindAppBar: true,
            body: BackButtonListener(
              onBackButtonPressed: () async{
                if(context.canPop()){
                  context.pop();
                  return true;
                }else{
                  AppDialogs.showConfirmationDialogToSaveDefaultSettings(context);
                  return true;
                }
              },
              child: Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        opacity: .5,
                        image: AssetImage(
                          AppAssets.confirmImage,
                        ),
                        fit: BoxFit.cover,
                      )),
                  child: SafeArea(
                      child: ClipRRect(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 2,
                                child: BlocBuilder<ConfirmBloc, ConfirmState>(
                                  builder: (context, state) {
                                    return Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                                'To continue please give the correct answer.',
                                                style: AppTextStyles.subTitleStyle(
                                                    fontSize: 16),
                                                textAlign: TextAlign.justify)),
                                        const SizedBox(height: 20),
                                        Text(
                                            '${state.firstNumber} ${state.operation} ${state.secondNumber} = ?',
                                            style: AppTextStyles.titleStyle(
                                                fontSize: 30)),
                                        const SizedBox(height: 20),
                                        Text('Answer: ${state.userAnswer}',
                                            style: AppTextStyles.titleStyle(
                                                fontSize: 30)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _confirmBloc
                                                    .add(const GenerateQuestion());
                                                // context
                                                //     .read<ConfirmBloc>()
                                                //     .add(const GenerateQuestion());
                                              },
                                              child: const Icon(Icons.refresh_rounded,
                                                  size: 40,
                                                  color: AppColors.appWhite),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                )),
                            Expanded(flex: 1, child: CustomKeyboard(confirmBloc: _confirmBloc, audioHandler: widget.audioHandler))
                          ],
                        ),
                      ))),
            )
        ));
  }
}
