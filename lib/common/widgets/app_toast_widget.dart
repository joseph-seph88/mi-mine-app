import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';

class AppToastWidget {
  static void showSuccess(BuildContext context, String message) {
    _showToast(
      context,
      message,
      AppColors.green.withAlpha(14),
      Icons.check_circle,
    );
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, AppColors.red.withAlpha(14), Icons.error);
  }

  static void showWarning(BuildContext context, String message) {
    _showToast(context, message, AppColors.orange.withAlpha(14), Icons.warning);
  }

  static void showInfo(BuildContext context, String message) {
    _showToast(context, message, AppColors.indigo.withAlpha(140), Icons.info);
  }

  static void _showToast(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(14),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => overlayEntry.remove(),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}
