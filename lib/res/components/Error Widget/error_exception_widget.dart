
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app_assets/app_assets.dart';
import '../../app_colors/app_colors.dart';
import '../../app_text_styles/text_styles.dart';

class ExceptionMessageWidget extends StatelessWidget {
  final bool isPlayerScreen;
  final String? msg;
  final VoidCallback onTap;
  const ExceptionMessageWidget({
    super.key,
    required this.isPlayerScreen,
    required this.msg,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: isPlayerScreen? width *.6 : width * .8,
          height: isPlayerScreen? height * .2 : height * .3,
          child: SvgPicture.asset(AppAssets.errorImage,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: isPlayerScreen? 20 : 30),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              msg.toString(),
              style: AppTextStyles.bodyStyle(),
              textAlign: TextAlign.center,
            ),
          )
        ),
        SizedBox(height: isPlayerScreen? 20 : 30),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: isPlayerScreen? 40 : 50,
            width: isPlayerScreen? 100 : 120,
            decoration: BoxDecoration(
              color: AppColors.normalTextColorDark,
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              enableFeedback: false,
              onTap: () => onTap(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Retry', style: AppTextStyles.subTitleStyle(
                    fontSize: isPlayerScreen? 12 : 14,
                    color: AppColors.themeColorDark,
                  ),),
                  Icon(
                    Icons.refresh_rounded,
                    size: isPlayerScreen? 20 : 25,
                    color: AppColors.themeColorDark,
                  )
                ],
              ),
            )

          ),
        ),

      ],);
  }
}
