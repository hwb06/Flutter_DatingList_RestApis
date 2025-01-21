import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const bodyText1 = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );

  static const bodyText2 = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );
}