
import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';
// App Text Styles class.
class AppTextStyles {

  // Title Style.
  static TextStyle titleStyle({double fontSize = 18, Color color = Colors.white}){
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      letterSpacing: 2,
    );
  }

  // Sub Title Style.
  static TextStyle subTitleStyle({double fontSize = 14, Color color = Colors.white}){
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      letterSpacing: 1.5,
    );
  }

  // Body Style.
  static TextStyle bodyStyle({double fontSize = 12, Color color = Colors.white}){
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w200,
        letterSpacing: 1
    );
  }

  static TextStyle categoryStyle({double fontSize = 14, Color color = AppColors.darkModeAppBarColor}){
    return TextStyle(
        color: color,
        fontFamily: 'Dosis-Regular',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 1
    );
  }

}
