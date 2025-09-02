import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/constants/image_path.dart';
import 'package:mimine/common/constants/rive_path.dart';
import 'package:mimine/common/widgets/input_field_form.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mimine/features/auth/presentation/cubits/login_cubit/login_state.dart';
import 'package:mimine/features/auth/presentation/enums/login_status.dart';
import 'package:rive/rive.dart' as rive;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            top: 300,
            left: 30,
            right: 30,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.success) {
                  context.goNamed(RouterName.home);
                } else if (state.status == LoginStatus.failure) {
                  // AppSnackBar.showError(context, state.errorMessage ?? "");
                }
              },
              builder: (context, state) => Container(
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
                child: Column(
                  children: [
                    _buildEmailField(context),
                    const SizedBox(height: 20),
                    _buildPasswordField(context),
                    const SizedBox(height: 24),
                    _buildLoginButton(context),
                    const SizedBox(height: 12),
                    _buildForgotPasswordButton(),
                    const SizedBox(height: 24),
                    _buildDivider(),
                    const SizedBox(height: 24),
                    _buildSocialLoginSection(),
                    const SizedBox(height: 24),
                    _buildSignupButton(context),
                  ],
                ),
              ),
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

  Widget _buildLogo() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withAlpha(150),
        border: Border.all(color: Colors.white.withAlpha(100), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.pets,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          const Text(
            "MIMINE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black54,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailError != current.emailError,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF5F5F5),
            border: Border.all(
              color: state.emailError != null
                  ? Colors.red.withAlpha(135)
                  : Colors.grey.withAlpha(77),
            ),
          ),
          child: InputFieldForm(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: '이메일',
            hintText: 'explorer@adventure.com',
            prefixIcon:
                const Icon(Icons.alternate_email, color: Colors.black54),
            errorText: state.emailError,
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.passwordError != current.passwordError ||
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF5F5F5),
            border: Border.all(
              color: state.passwordError != null
                  ? Colors.red.withAlpha(128)
                  : Colors.grey.withAlpha(77),
            ),
          ),
          child: InputFieldForm(
            controller: _passwordController,
            obscureText: !state.isPasswordVisible,
            labelText: '비밀번호',
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.black54,
              ),
              onPressed: () =>
                  context.read<LoginCubit>().togglePasswordVisibility(),
            ),
            errorText: state.passwordError,
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF8F9FA)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(77),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: state.status == LoginStatus.inProgress
              ? null
              : () {
                  context.read<LoginCubit>().login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: state.status == LoginStatus.inProgress
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.black54,
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore, color: Colors.black87, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '모험 시작하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.pushNamed(RouterName.forgotPassword),
        child: const Text(
          '길을 잃으셨나요?',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.withAlpha(77),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '또는',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey.withAlpha(77),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        const Text(
          '소셜 계정으로 빠른 출발',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialLoginButton(ImagePath.google, () {}, 'Google'),
            _buildSocialLoginButton(ImagePath.naver, () {}, 'Naver'),
            _buildSocialLoginButton(ImagePath.kakao, () {}, 'Kakao'),
          ],
        ),
      ],
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '아직 여행자가 아니신가요?',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          TextButton(
            onPressed: () => context.pushNamed(RouterName.signUp),
            child: const Text(
              '동반자 되기',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLoginButton(
      String imagePath, void Function()? onTap, String label) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(color: Colors.grey.withAlpha(52)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(26),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(imagePath),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
