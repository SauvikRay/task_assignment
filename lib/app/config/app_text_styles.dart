import 'package:flutter/material.dart';

import 'app_colors.dart';

/// AppTextStyle format as follows:
/// [fontWeight][fontSize][colorName][opacity]
/// Example: bold18White05
///
class AppTextStyles {
  AppTextStyles._();
  
 static  TextStyle boldTitle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  
  static  TextStyle placeHolderText = const TextStyle(
    fontSize: 17.36,
    color: AppColors.disabledColor,
  );

  static TextStyle disabledText= const TextStyle(fontSize: 13,color: AppColors.disabledColor,letterSpacing: 0.12);
}
