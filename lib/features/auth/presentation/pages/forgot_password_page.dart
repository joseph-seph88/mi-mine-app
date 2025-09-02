import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/constants/rive_path.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/input_field_form.dart';
import 'package:rive/rive.dart' as rive;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isEmailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 600,
            child: Container(
              color: Colors.transparent,
              child: _buildRiveAnimation(),
            ),
          ),
          Positioned(
            left: 10,
            right: 0,
            top: 60,
            child: _buildLeadingButton(),
          ),
          Positioned(
            top: 300,
            left: 30,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child:
                  _isEmailSent ? _buildSuccessContent() : _buildFormContent(),
            ),
          ),
          Positioned(
            top: 38,
            left: 100,
            right: 100,
            child: _buildLogo(),
          ),
        ],
      ),
    );
  }

  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
    }
  }

  Widget _buildRiveAnimation() {
    return rive.RiveAnimation.asset(
      RivePath.cat,
      fit: BoxFit.cover,
      artboard: 'Cat & Treat',
      onInit: _onRiveInit,
    );
  }

  Widget _buildLeadingButton() {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black87,
            size: 24,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.black.withAlpha(150),
        border: Border.all(color: AppColors.white.withAlpha(100), width: 2),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.pets,
            size: 30,
            color: AppColors.white,
          ),
          const SizedBox(width: 18),
          const Text(
            "MIMINE",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: AppColors.black54,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '비밀번호 찾기',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '가입하신 이메일 주소를 입력해주세요.\n비밀번호 재설정 링크를 보내드리겠습니다.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        _buildEmailField(),
        const SizedBox(height: 24),
        _buildSendButton(),
        const SizedBox(height: 16),
        _buildBackToLoginButton(),
      ],
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green.withAlpha(26),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.check_circle,
            size: 40,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '이메일을 전송했습니다!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black87,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '입력하신 이메일 주소로\n비밀번호 재설정 링크를 보내드렸습니다.\n이메일을 확인해주세요.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 32),
        _buildBackToLoginButton(),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              _isEmailSent = false;
            });
          },
          child: const Text(
            '다시 시도',
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF5F5F5),
        border: Border.all(
          color: Colors.grey.withAlpha(77),
        ),
      ),
      child: InputFieldForm(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        labelText: '이메일',
        hintText: 'adventure@mimine.com',
        prefixIcon: const Icon(Icons.alternate_email, color: Colors.black54),
      ),
    );
  }

  Widget _buildSendButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.white, Color(0xFFF8F9FA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withAlpha(77),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _sendResetEmail,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.black54,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, color: Colors.black87, size: 20),
                  SizedBox(width: 8),
                  Text(
                    '재설정 링크 보내기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black87,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.goNamed(RouterName.login),
        child: const Text(
          '로그인으로 돌아가기',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Future<void> _sendResetEmail() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일을 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: 실제 비밀번호 재설정 API 호출
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isEmailSent = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('비밀번호 재설정 링크가 전송되었습니다.'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
