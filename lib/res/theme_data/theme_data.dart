import 'package:flutter/material.dart';
import '../app_colors/app_colors.dart';
import '../app_text_styles/text_styles.dart';
import '../utils/Tooltip_shape/tooltip_shape.dart';

// App theme data class it has two static methods for getting the light & dark mode.
class AppThemeData {
  // Light theme data getter.
  static ThemeData get light => ThemeData(
      scaffoldBackgroundColor: AppColors.lightModeScaffoldColor,
      primarySwatch: Colors.green,
      brightness: Brightness.light,
      fontFamily: 'Dosis',
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
        actionsIconTheme:
            const IconThemeData(color: AppColors.appWhite, size: 25),
        surfaceTintColor: AppColors.themeColorLight,
        backgroundColor: AppColors.lightModeAppBarColor,
        foregroundColor: AppColors.appWhite,
        titleTextStyle: AppTextStyles.titleStyle(color: AppColors.appWhite),
      ),
      
      popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.menuColor,
          enableFeedback: false,
          shape: TooltipShape(),
          position: PopupMenuPosition.under),
      dialogTheme: DialogTheme(
          titleTextStyle: AppTextStyles.titleStyle(color: AppColors.appBlack),
          contentTextStyle: AppTextStyles.bodyStyle(color: AppColors.appBlack),
          backgroundColor: AppColors.lightModeScaffoldColor,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20)),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          enableFeedback: false,
          animationDuration: Duration(milliseconds: 300),
          alignment: Alignment.center,
        )
      )
  );

  // Dark mode theme data getter.
  static ThemeData get dark => ThemeData(
      scaffoldBackgroundColor: AppColors.darkModeScaffoldColor,
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      fontFamily: 'Dosis',
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.appWhite, size: 25),
        actionsIconTheme:
            const IconThemeData(color: AppColors.appWhite, size: 25),
        surfaceTintColor: AppColors.themeColorDark,
        backgroundColor: AppColors.darkModeAppBarColor,
        foregroundColor: AppColors.appWhite,
        titleTextStyle: AppTextStyles.titleStyle(color: AppColors.appWhite),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: AppColors.menuColor,
        enableFeedback: false,
        shape: TooltipShape(),
        position: PopupMenuPosition.under,
      ),
      dialogTheme: DialogTheme(
          titleTextStyle: AppTextStyles.titleStyle(),
          contentTextStyle: AppTextStyles.bodyStyle(),
          backgroundColor: AppColors.darkModeScaffoldColor,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20)),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            enableFeedback: false,
            animationDuration: Duration(milliseconds: 300),
            alignment: Alignment.center,
          )
      )
  );
}
