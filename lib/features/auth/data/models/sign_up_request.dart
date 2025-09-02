import 'package:mimine/features/auth/domain/entites/sign_up_data.dart';

class SignUpRequest {
  final String email;
  final String password;
  final String nickname;
  final String? phone;
  final String? gender;
  final String? birth;
  final String? profileImage;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.nickname,
    required this.phone,
    required this.gender,
    required this.birth,
    required this.profileImage,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      email: json['email'],
      password: json['password'],
      nickname: json['nickname'],
      phone: json['phone'],
      gender: json['gender'],
      birth: json['birth'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'nickname': nickname,
      'phone': phone,
      'gender': gender,
      'birth': birth,
      'profileImage': profileImage,
    };
  }

  @override
  String toString() {
    return 'SignUpRequest(email: $email, password: $password, nickname: $nickname, phone: $phone, gender: $gender, birth: $birth, profileImage: $profileImage)';
  }

  factory SignUpRequest.fromSignUpData(SignUpData signUpData) {
    return SignUpRequest(
      email: signUpData.email,
      password: signUpData.password,
      nickname: signUpData.nickname,
      phone: signUpData.phone,
      gender: signUpData.gender,
      birth: signUpData.birth,
      profileImage: signUpData.profileImage,
    );
  }
}
