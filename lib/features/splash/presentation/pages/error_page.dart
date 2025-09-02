import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/constants/rive_path.dart';
import 'package:rive/rive.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 500,
              child: RiveAnimation.asset(
                RivePath.drive,
                fit: BoxFit.contain,
                onInit: (artboard) {
                  final controller = StateMachineController.fromArtboard(
                      artboard, 'Drive machine');
                  if (controller != null) {
                    artboard.addController(controller);
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '페이지를 찾을 수 없습니다',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.goNamed(RouterName.login),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '로그인 페이지로 이동',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
