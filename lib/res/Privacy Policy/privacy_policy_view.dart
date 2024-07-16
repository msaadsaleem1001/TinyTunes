import 'package:TinyTunes/res/app_urls/app_urls.dart';
import 'package:TinyTunes/res/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy {

  static Future<void> launchInBrowserView(BuildContext context) async {
    if (!await launchUrl(AppUrls.privacyPolicy, mode: LaunchMode.inAppBrowserView)) {
      if(context.mounted){
      AppToast.showToast(context: context, message: 'Could not open browser');
      }
    }
  }

}