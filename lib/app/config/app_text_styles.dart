import 'package:flutter/material.dart';

import 'app_colors.dart';

/// AppTextStyle format as follows:
/// [fontWeight][fontSize][colorName][opacity]
/// Example: bold18White05
///
class AppTextStyles {
  AppTextStyles._();

  static TextStyle boldTitle = const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle appBarTitle({Color? color}) =>  TextStyle(fontSize: 22.57, fontWeight: FontWeight.bold, color:color ?? Colors.black);

  static TextStyle placeHolderText = const TextStyle(fontSize: 17.36, color: AppColors.disabledColor);
  static TextStyle createAccount = const TextStyle(fontSize: 17.36, fontWeight: FontWeight.normal, color: AppColors.accountCreation);
  static TextStyle textButton = const TextStyle(fontSize: 17.36, fontWeight: FontWeight.bold, color: AppColors.textButton);

  static TextStyle disabledText = const TextStyle(fontSize: 13, color: AppColors.disabledColor, letterSpacing: 0.12);
  static TextStyle productText = const TextStyle(fontSize: 13, color: Colors.black, letterSpacing: 0.12);
  static TextStyle warningText =  const TextStyle(fontSize: 14, color: AppColors.scaffoldColor,fontWeight: FontWeight.w400, letterSpacing: 0.12);
  static TextStyle disableText({Color? color}) =>   TextStyle(fontSize: 15.63, color:color?? AppColors.disableTextColor,fontWeight: FontWeight.normal, letterSpacing: 0.14);
}
