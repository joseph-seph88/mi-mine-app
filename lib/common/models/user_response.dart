class UserResponse {
  final String id;
  final String nickname;
  final String email;
  final String? motto;
  final String? profileImage;
  final String? accessToken;
  final String? refreshToken;

  UserResponse({
    required this.id,
    required this.nickname,
    required this.email,
    this.motto,
    this.profileImage,
    this.accessToken,
    this.refreshToken,
  });

  factory UserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserResponse(
        id: '',
        nickname: '',
        email: '',
      );
    }

    return UserResponse(
      id: json['id'] ?? '',
      nickname: json['nickname'] ?? '',
      email: json['email'] ?? '',
      motto: json['motto'],
      profileImage: json['profileImage'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'motto': motto,
      'profileImage': profileImage,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, nickname: $nickname, email: $email, motto: $motto, profileImage: $profileImage, accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
