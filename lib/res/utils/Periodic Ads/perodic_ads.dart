import 'dart:async';
import 'package:TinyTunes/Network%20Connectivity/check_internet.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../Unity Ads Services/unity_ads_services.dart';
import '../../routes/app_route_constants.dart';

class PeriodicAds {
  Timer? _timer;

  PeriodicAds(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 720), (timer) async{
      // debugPrint('Timer tick: ${timer.tick.toString()}');
      await CheckInternetConnection.checkInternetConnectionFunction().then( (isAvailable) async{
        if(isAvailable){
          GoRouter.of(context).pushNamed(AppRouteConstants.videoAdScreen);
          await Future.delayed(const Duration(seconds: 2));
          await InterstitialUnityAdsManager.loadInterstitialAd().then((value) async{
            if(value){
              GoRouter.of(context).pop();
              await InterstitialUnityAdsManager.showInter();
            }else{
              GoRouter.of(context).pop();
            }
          });
        }
      });
    });
  }

  Future<void> showFirstAd(BuildContext context, int seconds) async{
    Future.delayed(Duration(seconds: seconds), () async{
      await CheckInternetConnection.checkInternetConnectionFunction().then((isAvailable) async{
        if(isAvailable){
          GoRouter.of(context).pushNamed(AppRouteConstants.videoAdScreen);
          await Future.delayed(const Duration(seconds: 2));
          await InterstitialUnityAdsManager.loadInterstitialAd().then((value) async{
            if(value){
              GoRouter.of(context).pop();
              await InterstitialUnityAdsManager.showInter();
            }else{
              GoRouter.of(context).pop();
            }
          });
        }
      });
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
