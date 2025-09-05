class UserRequest {
  final String? nickname;
  final String? profileImage;

  UserRequest({
    this.nickname,
    this.profileImage,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      nickname: json['nickname'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'profileImage': profileImage,
    };
  }

  @override
  String toString() {
    return 'UserRequest(nickname: $nickname, profileImage: $profileImage)';
  }
}
