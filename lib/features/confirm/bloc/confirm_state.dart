
import 'package:equatable/equatable.dart';

class ConfirmState extends Equatable{

  final int firstNumber;
  final int secondNumber;
  final int correctAnswer;
  final String operation;
  final int userAnswer;

  const ConfirmState({
    this.firstNumber = 0,
    this.secondNumber = 0,
    this.operation = '+',
    this.userAnswer = 0,
    this.correctAnswer = 0
  });

  ConfirmState copyWith({
    int? firstNumber,
    int? secondNumber,
    String? operation,
    int? userAnswer,
    int? correctAnswer
  }){
    return ConfirmState(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      operation: operation ?? this.operation,
      userAnswer: userAnswer ?? this.userAnswer,
      correctAnswer: correctAnswer ?? this.correctAnswer
    );
  }

  @override
  List<Object?> get props => [firstNumber, secondNumber, operation, userAnswer, correctAnswer];

}