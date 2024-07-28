import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import '../Network Connectivity/check_internet.dart';
import '../res/utils/Get Device Id/get_device_id.dart';

class FirebaseAnalyticsEvents {

  static Future<void> openAppEvent() async {

    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        final String? deviceId = await GetDeviceId.getId();
        await FirebaseAnalytics.instance.setUserId(id: deviceId);
        await FirebaseAnalytics.instance
            .logEvent(
              name: "app_opened",
              parameters: {
                "device_id": deviceId!,
              },
            )
            .then((value) => debugPrint(
                'Firebase Analytics Event Success full of openAppEvent'))
            .onError((error, stackTrace) => debugPrint(
                'Firebase Analytics Event Error of openAppEvent: ${error.toString()}'));
      } catch (e) {
        debugPrint(
            'Firebase Analytics Event Error in openAppEvent: ${e.toString()}');
      }
    }
  }

  static Future<void> onTapOnVideoEvent() async {
    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        final String? deviceId = await GetDeviceId.getId();
        await FirebaseAnalytics.instance
            .logEvent(
          name: "tap_on_video_event",
          parameters: {
            "user_device": deviceId!,
          },
        ).then((value) => debugPrint(
            'Firebase Analytics Event Success full of onTapOnVideoEvent'))
            .onError((error, stackTrace) => debugPrint(
            'Firebase Analytics Event Error of onTapOnVideoEvent: ${error.toString()}'));
      } catch (e) {
        debugPrint(
            'Firebase Analytics Event Error in onTapOnVideoEvent: ${e.toString()}');
      }
    }
  }

  static Future<void> selectedCategory(String category) async {
    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        await FirebaseAnalytics.instance
            .logEvent(
          name: "categories_watched",
          parameters: {
            "category": category,
          },
        ).then((value) => debugPrint(
            'Firebase Analytics Event Success full of selectedCategoryEvent'))
            .onError((error, stackTrace) => debugPrint(
            'Firebase Analytics Event Error of selectedCategoryEvent: ${error.toString()}'));
      } catch (e) {
        debugPrint(
            'Firebase Analytics Event Error in selectedCategoryEvent: ${e.toString()}');
      }
    }
  }

  static Future<void> adSkipped() async {
    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        await FirebaseAnalytics.instance
            .logEvent(
          name: "ad_skipped",
        ).then((value) => debugPrint(
            'Firebase Analytics Event Success full of Ad Skipped'))
            .onError((error, stackTrace) => debugPrint(
            'Firebase Analytics Event Error of Ad Skipped: ${error.toString()}'));
      } catch (e) {
        debugPrint(
            'Firebase Analytics Event Error in Ad Skipped: ${e.toString()}');
      }
    }
  }

  static Future<void> adClicked() async {
    if (await CheckInternetConnection.checkInternetConnectionFunction()) {
      try {
        await FirebaseAnalytics.instance
            .logEvent(
          name: "ad_click",
        ).then((value) => debugPrint(
            'Firebase Analytics Event Success full of Ad Clicked'))
            .onError((error, stackTrace) => debugPrint(
            'Firebase Analytics Event Error of Ad Clicked: ${error.toString()}'));
      } catch (e) {
        debugPrint(
            'Firebase Analytics Event Error in Ad Clicked: ${e.toString()}');
      }
    }
  }

}
