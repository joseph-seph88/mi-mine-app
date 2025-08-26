import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/input_field_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.white,
              AppColors.white100,
              AppColors.white200,
              AppColors.white300,
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(children: [
                        _buildLeadingButton(),
                        const SizedBox(height: 20),
                        _buildLogo(),
                        const SizedBox(height: 20),
                        _buildTitle(),
                        const SizedBox(height: 8),
                        _buildSlogan(),
                      ])),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withAlpha(26),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildNameField(context),
                        const SizedBox(height: 20),
                        _buildEmailField(context),
                        const SizedBox(height: 20),
                        _buildPasswordField(context),
                        const SizedBox(height: 20),
                        _buildConfirmPasswordField(context),
                        const SizedBox(height: 32),
                        _buildSignUpButton(context),
                        const SizedBox(height: 20),
                        _buildLoginRedirect(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grey.withAlpha(26),
        border: Border.all(color: AppColors.grey.withAlpha(77), width: 2),
      ),
      child: const Icon(
        Icons.luggage,
        size: 50,
        color: AppColors.black87,
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '여행 동반자 되기',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.black87,
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: AppColors.black12,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSlogan() {
    return const Text(
      '새로운 모험가를 환영합니다',
      style: TextStyle(
        fontSize: 16,
        color: AppColors.black54,
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: AppColors.black12,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNameField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white400,
        border: Border.all(
          color: AppColors.grey.withAlpha(77),
        ),
      ),
      child: InputFieldForm(
        controller: _nameController,
        keyboardType: TextInputType.name,
        labelText: '여행자 이름',
        hintText: '홍길동',
        prefixIcon: const Icon(Icons.person_outline, color: AppColors.black54),
        errorText: null,
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white400,
        border: Border.all(
          color: AppColors.grey.withAlpha(77),
        ),
      ),
      child: InputFieldForm(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        labelText: '이메일',
        hintText: 'adventurer@travel.com',
        prefixIcon: const Icon(Icons.alternate_email, color: AppColors.black54),
        errorText: null,
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white400,
        border: Border.all(
          color: AppColors.grey.withAlpha(77),
        ),
      ),
      child: InputFieldForm(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        labelText: '비밀번호',
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.black54),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.black54,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        errorText: null,
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white400,
        border: Border.all(
          color: AppColors.grey.withAlpha(77),
        ),
      ),
      child: InputFieldForm(
        controller: _confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        labelText: '비밀번호 확인',
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.black54),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.black54,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        errorText: null,
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.white, AppColors.white100],
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
        onPressed: () {
          // 회원가입 로직 구현
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('여행 준비가 완료되었습니다!'),
              backgroundColor: Colors.grey,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_travel, color: AppColors.black87, size: 20),
            SizedBox(width: 8),
            Text(
              '여행 준비 완료',
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

  Widget _buildLoginRedirect(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '이미 여행 동반자이신가요?',
            style: TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(
              '로그인하기',
              style: TextStyle(
                color: AppColors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
