
import 'package:TinyTunes/features/confirm/bloc/confirm_bloc.dart';
import 'package:TinyTunes/res/components/Custom%20Keyboard/single_button.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final AudioHandler audioHandler;
  final ConfirmBloc confirmBloc;
  const CustomKeyboard({super.key, required this.audioHandler, required this.confirmBloc});

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Container(
      margin: const EdgeInsets.only(right: 30, bottom: 20),
      width: width * .3,
      height: height * .6,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: .5,
          mainAxisExtent: 50
        ),
        itemBuilder: (context, index) {
          if(index == 9){
            return KeyboardButton(value: 'back', confirmBloc: widget.confirmBloc, handler: widget.audioHandler);
          }else if(index == 10){
            return KeyboardButton(value: '0', confirmBloc: widget.confirmBloc, handler: widget.audioHandler);
          }else if(index == 11){
            return KeyboardButton(value: 'forward', confirmBloc: widget.confirmBloc, handler: widget.audioHandler);
          }else{
            return KeyboardButton(value: (++index).toString(), confirmBloc: widget.confirmBloc, handler: widget.audioHandler);
          }

        },
      ),
    );
  }
}
