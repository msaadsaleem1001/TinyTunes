import 'package:TinyTunes/features/home_feed/bloc/home_bloc.dart';
import 'package:TinyTunes/features/home_feed/bloc/home_event.dart';
import 'package:TinyTunes/res/Privacy%20Policy/privacy_policy_view.dart';
import 'package:TinyTunes/res/app_assets/app_assets.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:TinyTunes/res/utils/Dialog/confirmation_dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/setting/bloc/setting_bloc.dart';
import '../../../features/setting/bloc/setting_event.dart';
import '../../app_colors/app_colors.dart';
import '../../app_text_styles/text_styles.dart';

class TinyTunesAppBars {

  static AppBar homeAppBar(BuildContext context, HomeBloc homeBloc) {
    return AppBar(
      titleSpacing: 5,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset(AppAssets.textLogo,
          height: 100, width: 200, fit: BoxFit.cover),
      actions: [
        GestureDetector(
            onTap: () {
              homeBloc.add(const GetVideos());
            },
            child: const Icon(Icons.refresh_rounded,
                size: 30, color: AppColors.appWhite)),
        const SizedBox(width: 30),
        GestureDetector(
            onTap: () {
              homeBloc.add(const OnScreenChange(isFirstScreen: false));
              GoRouter.of(context).pushNamed(AppRouteConstants.confirm);
            },
            child: const Icon(Icons.lock_rounded,
                size: 30, color: AppColors.appWhite)),
        const SizedBox(width: 20),
      ],
    );
  }

  static AppBar confirmAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          if(context.canPop()){
            context.pop();
          }else{
            AppDialogs.showConfirmationDialogToSaveDefaultSettings(context);
          }
        },
        child: const Icon(Icons.arrow_back_ios_rounded, size: 30, color: AppColors.appWhite),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        'Parents Only',
        style: AppTextStyles.titleStyle(fontSize: 22),
      ),
    );
  }

  static AppBar settingsAppBar(BuildContext context, SettingBloc setting){
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Text('Setting', style: AppTextStyles.titleStyle()),
      actions: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: (){
                  PrivacyPolicy.launchInBrowserView(context);
                },
                child: const Image(image: AssetImage(AppAssets.privacyImage), width: 25, height: 25, fit: BoxFit.cover),
            )),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: (){
                  setting.add(OnSaveEvent(context: context));
                },
                child: const Icon(Icons.arrow_forward_ios_rounded, size: 30, color: AppColors.appWhite)
            )),
      ],
    );
  }

  static AppBar playerAppBar(BuildContext context){
    return AppBar(
      leading: InkWell(
        enableFeedback: false,
        onTap: (){
          if(GoRouter.of(context).canPop()){
            context.pop();
            context.read<HomeBloc>().add(const OnScreenChange(isFirstScreen: true));
          }
        },
        child: const Icon(Icons.arrow_back_ios_rounded, size: 30, color: AppColors.appWhite),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

}
