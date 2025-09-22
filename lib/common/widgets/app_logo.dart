import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final String text;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const LogoWidget({
    super.key,
    this.size = 120,
    this.text = "MIMINE",
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.iconSize = 60,
    this.borderColor = Colors.white,
    this.borderWidth = 2,
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor.withAlpha(150),
            border: Border.all(
              color: borderColor.withAlpha(100),
              width: borderWidth,
            ),
          ),
          child: Icon(
            Icons.pets,
            size: iconSize,
            color: iconColor,
          ),
        ),
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: ArcTextPainter(
              text: text,
              radius: size * 0.33,
              startAngle: pi,
              sweepAngle: pi,
              textStyle: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black54,
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}

class SmallLogoWidget extends StatelessWidget {
  final double size;
  final String text;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  const SmallLogoWidget({
    super.key,
    this.size = 48,
    this.text = "MIMINE",
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.iconSize = 24,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.textColor = Colors.white,
    this.fontSize = 8,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor.withAlpha(25),
        border: Border.all(
          color: borderColor.withAlpha(100),
          width: borderWidth,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.pets,
            size: iconSize,
            color: iconColor,
          ),
          Positioned(
            top: 2,
            child: SizedBox(
              width: size - 6,
              height: size - 6,
              child: CustomPaint(
                painter: ArcTextPainter(
                  text: text,
                  radius: (size - 6) * 0.4,
                  startAngle: pi,
                  sweepAngle: pi,
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArcTextPainter extends CustomPainter {
  final String text;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final TextStyle textStyle;

  ArcTextPainter({
    required this.text,
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final characters = text.split('');
    final angleStep = sweepAngle / (characters.length - 1);

    for (int i = 0; i < characters.length; i++) {
      final textSpan = TextSpan(
        text: characters[i],
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      final angle = startAngle + (i * angleStep);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + pi / 2);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OvalLogoWidget extends StatelessWidget {
  const OvalLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.black.withAlpha(52),
        border: Border.all(color: AppColors.black.withAlpha(72), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.pets,
            size: 24,
            color: AppColors.white,
          ),
          const SizedBox(width: 8),
          Text("MIMINE", style: AppTextStyles.whiteF16WBShadow),
        ],
      ),
    );
  }
}
