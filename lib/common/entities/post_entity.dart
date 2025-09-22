class PostEntity {
  final String? postId;
  final String? userId;
  final String? nickname;
  final String? profileImage;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  final bool? isBookMarked;
  final List<String>? tags;

  PostEntity({
    this.postId,
    this.userId,
    this.nickname,
    this.profileImage,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.title,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isBookMarked,
    this.tags,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      postId: json['postId'],
      userId: json['userId'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      shareCount: json['shareCount'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isBookMarked: json['isBookMarked'],
      tags: json['tags'],
    );
  }

  PostEntity copyWith({
    String? postId,
    String? userId,
    String? nickname,
    String? profileImage,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    String? title,
    String? description,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
    bool? isBookMarked,
    List<String>? tags,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isBookMarked: isBookMarked ?? this.isBookMarked,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'PostEntity(postId: $postId, userId: $userId, nickname: $nickname, profileImage: $profileImage, likeCount: $likeCount, commentCount: $commentCount, shareCount: $shareCount, title: $title, description: $description, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isBookMarked: $isBookMarked, tags: $tags)';
  }
}
