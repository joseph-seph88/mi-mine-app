import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';

class AppTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final TooltipTriggerMode triggerMode;
  final Duration waitDuration;
  final Duration showDuration;
  final bool preferBelow;
  final double verticalOffset;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool enableFeedback;

  const AppTooltip({
    super.key,
    required this.child,
    required this.message,
    this.triggerMode = TooltipTriggerMode.tap,
    this.waitDuration = const Duration(milliseconds: 300),
    this.showDuration = const Duration(seconds: 3),
    this.preferBelow = true,
    this.verticalOffset = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.borderRadius = 12,
    this.textStyle,
    this.backgroundColor,
    this.enableFeedback = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? Colors.black.withOpacity(0.88);
    final TextStyle style = textStyle ??
        const TextStyle(color: Colors.white, fontSize: 12.5, height: 1.3);

    return Tooltip(
      message: message,
      triggerMode: triggerMode,
      waitDuration: waitDuration,
      showDuration: showDuration,
      preferBelow: preferBelow,
      verticalOffset: verticalOffset,
      padding: padding,
      margin: margin,
      textStyle: style,
      decoration: ShapeDecoration(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
              color: (AppColors.grey).withAlpha(20), width: 0.5),
        ),
        shadows: const [
          BoxShadow(blurRadius: 8, color: Colors.black26, offset: Offset(0, 2)),
        ],
      ),
      enableFeedback: enableFeedback,
      child: child,
    );
  }
}
