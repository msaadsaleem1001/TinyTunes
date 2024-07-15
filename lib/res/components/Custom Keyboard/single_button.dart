
import 'package:TinyTunes/features/confirm/bloc/confirm_bloc.dart';
import 'package:TinyTunes/features/confirm/bloc/confirm_event.dart';
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/app_text_styles/text_styles.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final ConfirmBloc confirmBloc;
  final String value;
  final AudioHandler handler;
  const KeyboardButton({super.key, required this.value, required this.confirmBloc, required this.handler});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(value == 'back'){
          // debugPrint('Back');
          confirmBloc.add(const OnClearEvent());
        }else if(value == 'forward'){
          // debugPrint('Forward');
          confirmBloc.add(OnSubmitEvent(context: context));
        }else{
          // debugPrint(value);
          confirmBloc.add(OnUserAnswer(enteredValue: int.parse(value)));
        }
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
            shape: BoxShape.circle
        ),
        child: Center(
          child: value == 'back'
              ? const Icon(Icons.close_rounded, color: AppColors.appWhite)
              : value == 'forward'
              ? const Icon(Icons.arrow_forward_rounded, color: AppColors.appWhite)
              : Text(value, style: AppTextStyles.subTitleStyle(fontSize: 20))
        ),
      ),
    );
  }
}
