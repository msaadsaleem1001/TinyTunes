
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/app_text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class VideoAdScreen extends StatefulWidget {
  const VideoAdScreen({super.key});

  @override
  State<VideoAdScreen> createState() => _VideoAdScreenState();
}

class _VideoAdScreenState extends State<VideoAdScreen> {
  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: ()async{
        // debugPrint('Back button pressed!');
        return true;
      },
      child: Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.lightModeAppBarColor,
                ),
              ),
              const SizedBox(width: 10),
              Text('Ad Loading...', style: AppTextStyles.categoryStyle(color: AppColors.darkModeAppBarColor))
            ],
          )
        ],
      ),
    )
    );
  }
}
