class UserEntity {
  final int? userId;
  final String? email;
  final String? nickname;
  final String? motto;
  final int? contentsCount;
  final String? profileImage;
  final String? errorMessage;
  final bool isSuccess;
  final List<Map<String, dynamic>>? friends;
  final List<Map<String, dynamic>>? followers;

  UserEntity({
    this.userId,
    this.email,
    this.nickname,
    this.motto,
    this.contentsCount,
    this.profileImage,
    this.errorMessage,
    this.isSuccess = false,
    this.friends = const [],
    this.followers = const [],
  });

  factory UserEntity.fromJson(
    Map<String, dynamic> json,
    String errorMessage,
    bool isSuccess,
  ) {
    return UserEntity(
      userId: json['userId'],
      email: json['email'],
      nickname: json['nickname'],
      motto: json['motto'],
      contentsCount: json['contentsCount'],
      profileImage: json['profileImage'],
      errorMessage: errorMessage,
      isSuccess: isSuccess,
      friends: json['friends'],
      followers: json['followers'],
    );
  }

  UserEntity copyWith({
    int? userId,
    String? email,
    String? nickname,
    String? motto,
    int? contentsCount,
    String? profileImage,
    String? errorMessage,
    bool? isSuccess,
    List<Map<String, dynamic>>? friends,
    List<Map<String, dynamic>>? followers,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      motto: motto ?? this.motto,
      contentsCount: contentsCount ?? this.contentsCount,
      profileImage: profileImage ?? this.profileImage,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      friends: friends ?? this.friends,
      followers: followers ?? this.followers,
    );
  }

  @override
  String toString() {
    return 'UserEntity(userId: $userId, email: $email, nickname: $nickname, motto: $motto, contentsCount: $contentsCount, profileImage: $profileImage, errorMessage: $errorMessage, isSuccess: $isSuccess, friends: $friends, followers: $followers)';
  }
}
