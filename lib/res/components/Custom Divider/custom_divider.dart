
import 'package:flutter/material.dart';
import '../../app_colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      height: 2,
      width: width,
      decoration: const BoxDecoration(color: AppColors.appWhite),
    );
  }
}
