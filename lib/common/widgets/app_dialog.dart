import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/app_logo.dart';

abstract class AppDialog extends StatelessWidget {
  const AppDialog({super.key});

  // 공통 다이얼로그 스타일
  static const double _borderRadius = 16.0;
  static const double _elevation = 8.0;
  static const EdgeInsets _contentPadding = EdgeInsets.all(24.0);

  // 기본 다이얼로그 스타일
  static AlertDialog _buildBaseDialog({
    required Widget content,
    String? title,
    List<Widget>? actions,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      elevation: _elevation,
      contentPadding: _contentPadding,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ],
          content,
          if (actions != null) ...[
            const SizedBox(height: 24),
            Row(
              children: actions,
            ),
          ],
        ],
      ),
    );
  }

  // 아이콘 다이얼로그
  static void showIconDialog({
    required BuildContext context,
    required String title,
    required String message,
    required List<Widget> actions,
    Color? iconColor,
    Color? iconBackgroundColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildBaseDialog(
        content: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmallLogoWidget(
                      size: 68,
                      text: "MIMINE-JOSEPH",
                      backgroundColor: AppColors.primary,
                      iconColor: AppColors.primary,
                      iconSize: 34,
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                      fontSize: 12,
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }

  // 기본 버튼 스타일
  static Widget buildTextButton({
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor ?? AppColors.grey,
          ),
        ),
      ),
    );
  }

  static Widget buildElevatedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
