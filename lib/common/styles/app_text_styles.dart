import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';

abstract class AppTextStyles {
  // HomePage ::

  // Color : Primary
  static const TextStyle primaryF16W600 = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle primaryWA217F13 = TextStyle(
    color: AppColors.primary.withAlpha(217),
    fontSize: 13,
  );

  static TextStyle primaryF13W600LS = TextStyle(
    color: AppColors.primary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Color : Grey
  static TextStyle greyF13 = TextStyle(
    color: AppColors.grey,
    fontSize: 13,
  );

  static TextStyle greyWA204F13W400H13 = TextStyle(
    color: AppColors.grey.withAlpha(204),
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static TextStyle greyWA204F12W400H13 = TextStyle(
    color: AppColors.grey.withAlpha(204),
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static TextStyle greyWA178F12 = TextStyle(
    color: AppColors.grey.withAlpha(178),
    fontSize: 12,
  );

  // Color : Black
  static TextStyle blackF24W700H135 = TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  static const TextStyle blackF20W800LS = TextStyle(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static TextStyle blackF18W700 = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle blackF16H145 = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    height: 1.45,
  );

  static TextStyle blackF16W700H12 = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static TextStyle blackF14W700H12 = TextStyle(
    color: AppColors.black,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  // Color : White
  static TextStyle whiteF20WB = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle whiteWA180F14 = TextStyle(
    color: Colors.white.withAlpha(180),
    fontSize: 14,
  );

  // AppLogo
  static TextStyle whiteF16WBShadow = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    shadows: [
      Shadow(
        blurRadius: 2.0,
        color: Colors.black54,
        offset: Offset(1.0, 1.0),
      ),
    ],
  );
}
