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
  static TextStyle greyF13 = TextStyle(color: AppColors.grey, fontSize: 13);

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
      Shadow(blurRadius: 2.0, color: Colors.black54, offset: Offset(1.0, 1.0)),
    ],
  );

  // Search Page Styles
  static TextStyle searchHintF16 = TextStyle(
    color: AppColors.grey,
    fontSize: 16,
  );

  static TextStyle searchTextF16W500 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle searchResultPrimaryF16W600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  static TextStyle searchResultSecondaryF14W400 = TextStyle(
    color: Color(0xFF666666),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle recentSearchTitleF20W800LS = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.black87,
    letterSpacing: -0.5,
  );

  static TextStyle deleteAllF12W500 = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );

  static TextStyle recentSearchItemF14W600 = TextStyle(
    fontSize: 14,
    color: AppColors.black87,
    fontWeight: FontWeight.w600,
  );

  static TextStyle emptyStateTitleF18W600 = TextStyle(
    fontSize: 18,
    color: AppColors.grey,
    fontWeight: FontWeight.w600,
  );

  static TextStyle emptyStateSubtitleF14 = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
  );

  static TextStyle highlightTextF16W600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black87,
  );

  static TextStyle highlightTextF16W600Green = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF00945A),
  );

  // Settings Page Styles
  static TextStyle mottoF16WB = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1E40AF), // Colors.blue[800]
  );

  static TextStyle todayThoughtF14H14 = TextStyle(
    fontSize: 14,
    color: Color(0xFF1D4ED8), // Colors.blue[700]
    height: 1.4,
  );

  static TextStyle viewAllButtonF14 = TextStyle(
    color: Color(0xFF1E40AF), // Colors.blue[800]
    fontSize: 14,
  );

  static TextStyle activityTitleF16W600 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle activityDescriptionF14 = TextStyle(
    fontSize: 14,
    color: Color(0xFF6B7280), // Colors.grey[600]
  );

  static TextStyle activityTimeF12 = TextStyle(
    fontSize: 12,
    color: Color(0xFF9CA3AF), // Colors.grey[500]
  );
}
