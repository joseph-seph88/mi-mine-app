import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
      onPressed: () => context.pop(),
    );
  }
}
