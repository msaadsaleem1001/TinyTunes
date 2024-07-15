
import 'package:flutter/cupertino.dart';

class CustomDivider {

  static Widget divider({bool player = false}) {
    return SizedBox(width: player? 20 : 30);
  }

}