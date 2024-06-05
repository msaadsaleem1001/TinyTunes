
import 'package:flutter/material.dart';
import '../../app_colors/app_colors.dart';

class ShortsLoading extends StatelessWidget {
  const ShortsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: AppColors.themeColorLight,
            strokeWidth: 4,
          )),
    );
  }
}
