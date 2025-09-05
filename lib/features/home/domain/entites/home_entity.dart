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
    );
  }

  @override
  String toString() {
    return 'HomeEntity(userId: $userId, email: $email, nickname: $nickname, motto: $motto, profileImage: $profileImage, errorMessage: $errorMessage, isSuccess: $isSuccess, bestContents: $bestContents, allContents: $allContents)';
  }
}
