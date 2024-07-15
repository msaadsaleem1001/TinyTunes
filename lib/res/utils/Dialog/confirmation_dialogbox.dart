import 'dart:async';
import 'package:TinyTunes/Models/Category%20Setting%20Model/settings_model.dart';
import 'package:TinyTunes/Repository/Settings%20Repo/settings_repo.dart';
import 'package:TinyTunes/res/app_colors/app_colors.dart';
import 'package:TinyTunes/res/routes/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter/services.dart';
import '../../app_constants/app_constants.dart';

class AppDialogs {

  static Future<bool> showSaveConfirmationDialog(BuildContext context) async {
    bool isConfirm = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation', textAlign: TextAlign.center),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppConstants.confirmationSave,
                    textAlign: TextAlign.center),
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
                isConfirm = true;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return isConfirm;
  }

  static Future<void> showConfirmationDialogToSaveDefaultSettings(
      BuildContext context) async {
    bool isLoading = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setBuilderState) {
          return AlertDialog(
            title: const Text('Confirmation', textAlign: TextAlign.center),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppConstants.confirmationSaveDefault,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            actions: <Widget>[
              isLoading == true
                  ? const SizedBox()
                  : TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
              isLoading == true
                  ? Container(
                      width: 15,
                      height: 15,
                      margin: const EdgeInsets.only(right: 30, bottom: 17, top: 17),
                      child: const CircularProgressIndicator(
                          strokeWidth: 3, color: AppColors.appWhite))
                  : TextButton(
                      child: const Text('Confirm'),
                      onPressed: () {
                        setBuilderState(() {
                          isLoading = true;
                        });
                        Timer(const Duration(seconds: 2), () async{
                          setBuilderState(() {
                            isLoading = false;
                          });
                          SettingsModel settingsModel = SettingsModel(type: 'Default', categories: AppConstants.categoryList);
                          await CategoryDatabase.updateCategoryBox(settingsModel).whenComplete(() {
                            if(context.canPop()){
                              context.pop();
                              GoRouter.of(context).pushReplacementNamed(AppRouteConstants.homeRoute);
                            }
                          });
                        });
                      },
                    )
            ],
          );
        });
      },
    );
  }

  // static Future<void> showDialogForMinimizeApp(BuildContext context) async {
  //   const androidAppRetain = MethodChannel("android_app_retain");
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // User must tap button to dismiss!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirmation', textAlign: TextAlign.center),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(AppConstants.confirmationMinimizeApp, textAlign: TextAlign.center),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Confirm'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               androidAppRetain.invokeMethod("sendToBackground");
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
