import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.pop(), icon: Icon(Icons.arrow_back_ios_new));
  }
}
