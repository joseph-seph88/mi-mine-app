class UserRequest {
  final String? nickname;
  final String? profileImage;
  final String? motto;
  final String? todayThought;
  UserRequest({
    this.nickname,
    this.profileImage,
    this.motto,
    this.todayThought,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      motto: json['motto'],
      todayThought: json['todayThought'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'profileImage': profileImage,
      'motto': motto,
      'todayThought': todayThought,
    };
  }

  @override
  String toString() {
    return 'UserRequest(nickname: $nickname, profileImage: $profileImage, motto: $motto, todayThought: $todayThought)';
  }
}
