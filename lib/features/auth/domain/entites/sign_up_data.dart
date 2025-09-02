class SignUpData {
  final String email;
  final String password;
  final String nickname;
  final String? phone;
  final String? gender;
  final String? birth;
  final String? profileImage;

  SignUpData({
    required this.email,
    required this.password,
    required this.nickname,
    required this.phone,
    required this.gender,
    required this.birth,
    required this.profileImage,
  });

  @override
  String toString() {
    return 'SignUpData(email: $email, password: $password, nickname: $nickname, phone: $phone, gender: $gender, birth: $birth, profileImage: $profileImage)';
  }
}
