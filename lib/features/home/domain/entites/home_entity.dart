class HomeEntity {
  final int? userId;
  final String? email;
  final String? nickname;
  final String? motto;
  final String? profileImage;
  final String? errorMessage;
  final bool isSuccess;
  final List<Map<String, dynamic>>? bestContents;
  final List<Map<String, dynamic>>? allContents;
  final List<Map<String, dynamic>>? friends;
  final List<Map<String, dynamic>>? followers;

  HomeEntity({
    this.userId,
    this.email,
    this.nickname,
    this.motto,
    this.profileImage,
    this.errorMessage,
    this.isSuccess = false,
    this.bestContents = const [],
    this.allContents = const [],
    this.friends = const [],
    this.followers = const [],
  });

  factory HomeEntity.fromJson(
      Map<String, dynamic>? json, String? errorMessage, bool isSuccess) {
    return HomeEntity(
      userId: json?['userId'],
      email: json?['email'],
      nickname: json?['nickname'],
      motto: json?['motto'],
      profileImage: json?['profileImage'],
      errorMessage: errorMessage,
      isSuccess: isSuccess,
      bestContents: json?['bestContents'],
      allContents: json?['allContents'],
      friends: json?['friends'],
      followers: json?['followers'],
    );
  }

  HomeEntity copyWith({
    int? userId,
    String? email,
    String? nickname,
    String? motto,
    String? profileImage,
    String? errorMessage,
    bool? isSuccess,
    List<Map<String, dynamic>>? bestContents,
    List<Map<String, dynamic>>? allContents,
    List<Map<String, dynamic>>? friends,
    List<Map<String, dynamic>>? followers,
  }) {
    return HomeEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      motto: motto ?? this.motto,
      profileImage: profileImage ?? this.profileImage,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      bestContents: bestContents ?? this.bestContents,
      allContents: allContents ?? this.allContents,
      friends: friends ?? this.friends,
      followers: followers ?? this.followers,
    );
  }

  @override
  String toString() {
    return 'HomeEntity(userId: $userId, email: $email, nickname: $nickname, motto: $motto, profileImage: $profileImage, errorMessage: $errorMessage, isSuccess: $isSuccess, bestContents: $bestContents, allContents: $allContents, friends: $friends, followers: $followers)';
  }
}
