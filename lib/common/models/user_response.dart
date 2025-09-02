class UserResponse {
  final String id;
  final String nickname;
  final String email;
  final String? accessToken;
  final String? refreshToken;

  UserResponse({
    required this.id,
    required this.nickname,
    required this.email,
    this.accessToken,
    this.refreshToken,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      nickname: json['nickname'],
      email: json['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, nickname: $nickname, email: $email, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
