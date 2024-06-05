import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../app_constants/app_constants.dart';

class AppDialogs {

  static Future<void> showConfirmationDialog(BuildContext context, YoutubePlayerController controller) async {
    controller.pauseVideo();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation', textAlign: TextAlign.center),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppConstants.confirmationFullScreen, textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                controller.playVideo();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
                controller.exitFullScreen(lock: true);
                controller.playVideo();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogForMinimizeApp(BuildContext context) async {
    const androidAppRetain = MethodChannel("android_app_retain");
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation', textAlign: TextAlign.center),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppConstants.confirmationMinimizeApp, textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
                androidAppRetain.invokeMethod("sendToBackground");
              },
            ),
          ],
        );
      },
    );
  }

}