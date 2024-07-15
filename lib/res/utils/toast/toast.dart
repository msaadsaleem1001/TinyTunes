import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../app_colors/app_colors.dart';

class AppToast {

  static void showToast(
      {required BuildContext context, required String message}) {
    if (context.mounted) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.menuColor,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14,
      );
    }
  }

  static void showToastForSelectCategory(
      {required BuildContext context, required String message}) {
    if (context.mounted) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.loadingColor1,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14,
      );
    }
  }

}
