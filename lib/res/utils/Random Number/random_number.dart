
import 'dart:math';

class RandomNumber {

  static int generateRandomNumber() {
    final Random random = Random();
    int min = 2;
    int max = 9;
    return min + random.nextInt(max - min + 1);
  }

  static String chooseOperation() {
    List<String> operators = ['+', 'x'];
    final Random random = Random();
    int randomIndexOperator = random.nextInt(operators.length);
    return operators[randomIndexOperator];
  }

}