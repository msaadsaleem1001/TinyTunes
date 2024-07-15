
import 'package:TinyTunes/features/confirm/bloc/confirm_event.dart';
import 'package:TinyTunes/features/confirm/bloc/confirm_state.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:TinyTunes/res/utils/Random%20Number/random_number.dart';
import 'package:TinyTunes/res/utils/toast/toast.dart';
import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ConfirmBloc extends Bloc<ConfirmEvent, ConfirmState> {

  int firstNumber = 0;
  int secondNumber = 0;
  String operation = '+';
  int correctAnswer = 0;
  int userAnswer = 0;

  ConfirmBloc() : super(const ConfirmState()) {
    on<GenerateQuestion>(_generateQuestion);
    on<OnUserAnswer>(_onUserInput);
    on<OnClearEvent>(_onClearEvent);
    on<OnSubmitEvent>(_onSubmit);
  }

  void _onSubmit(OnSubmitEvent event, Emitter<ConfirmState> emit){
    if(correctAnswer == userAnswer){
      while(GoRouter.of(event.context).canPop()){
        GoRouter.of(event.context).pop();
      }
      GoRouter.of(event.context).pushReplacementNamed(AppRouteConstants.setting);
    }else{
      AppToast.showToast(context: event.context, message: 'Please enter correct answer');
    }
  }

  void _onClearEvent(OnClearEvent event, Emitter<ConfirmState> emit){
    String answerLen = userAnswer.toString();
    if(answerLen.length < 2){
      userAnswer = 0;
      emit(state.copyWith(
          userAnswer: userAnswer
      ));
    }else{
      int newAnswer = int.parse(answerLen[0]);
      userAnswer = newAnswer;
      emit(state.copyWith(
          userAnswer: userAnswer
      ));
    }

  }

  void _onUserInput(OnUserAnswer event, Emitter<ConfirmState> emit){
    if(userAnswer == 0){
      userAnswer = event.enteredValue;
      emit(state.copyWith(
        userAnswer: userAnswer
      ));
    }else{
      String answerLen = userAnswer.toString();
      if(answerLen.length < 2){
        int finalAnswer = int.parse('$userAnswer${event.enteredValue}');
        userAnswer = finalAnswer;
        if(finalAnswer <= 99){
          emit(state.copyWith(
              userAnswer: userAnswer
          ));
        }
      }
    }
  }

  void _generateQuestion(GenerateQuestion event, Emitter<ConfirmState> emit) {
    firstNumber = RandomNumber.generateRandomNumber();
    secondNumber = RandomNumber.generateRandomNumber();
    operation = RandomNumber.chooseOperation();
    if(operation == '+'){
      correctAnswer = firstNumber + secondNumber;
    }else{
      correctAnswer = firstNumber * secondNumber;
    }
    // print(correctAnswer.toString());
    emit(state.copyWith(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operation: operation,
      correctAnswer: correctAnswer
    ));
  }

}