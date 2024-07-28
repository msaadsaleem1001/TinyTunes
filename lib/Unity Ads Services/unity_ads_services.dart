
import 'dart:io';
import 'package:TinyTunes/Firebase%20Analytics/firebase_analytics.dart';
import 'package:TinyTunes/Unity%20Ads%20Services/unity_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class InterstitialUnityAdsManager {

  static Future<void> init() async{
    late String gameId;
    if(Platform.isAndroid){
      gameId = UnityConstants.androidGameId;
    }
    else{
      gameId = UnityConstants.iosGameId;
    }
    try{
      await UnityAds.init(
        testMode: false,
        gameId: gameId,
        onComplete: () => debugPrint('Unity Ads Initialization Complete'),
        onFailed: (error, message) => debugPrint('Unity Ads Initialization Failed: $error $message'),
      );
    }catch(e){
      debugPrint('Error in catch while initializing unity ads: $e');
    }
  }

  static Future<bool> loadInterstitialAd() async{
    late String placementId;
    if(Platform.isAndroid){
      placementId = UnityConstants.interstitialAndroidPlacement;
    }
    else{
      placementId = UnityConstants.interstitialIosPlacement;
    }
    try{
      await UnityAds.load(
        placementId: placementId,
        onComplete: (placementId) => debugPrint('Load Unity Ad Complete $placementId'),
        onFailed: (placementId, error, message) => debugPrint('Load Unity Ad Failed $placementId: $error $message'),
      );
      return true;
    }catch(e){
      debugPrint('Error while loading video ad: $e');
      return false;
    }
  }

  static Future<void> showInter() async{
    late String placementId;
    if(Platform.isAndroid){
      placementId = UnityConstants.interstitialAndroidPlacement;
    }
    else{
      placementId = UnityConstants.interstitialIosPlacement;
    }
    try{
      await UnityAds.showVideoAd(
        placementId: placementId,
        onStart: (placementId) => debugPrint('Video Ad started'),
        onClick: (placementId) => FirebaseAnalyticsEvents.adClicked(),
        onSkipped: (placementId) => FirebaseAnalyticsEvents.adSkipped(),
        onComplete: (placementId) => debugPrint('Video Ad $placementId completed'),
        onFailed: (placementId, error, message) => debugPrint('Video Ad failed: $error $message'),
      );
      debugPrint('Successfully show video ad');
    }catch(e){
      debugPrint('Error while showing video ad: $e');
    }
  }

}