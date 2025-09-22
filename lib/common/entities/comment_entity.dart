class CommentEntity {
  final String id;
  final String postId;
  final String userId;
  final String nickname;
  final String profileImage;
  final String comment;
  final String replyComment;
  final String createdAt;
  final String updatedAt;

  CommentEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.nickname,
    required this.profileImage,
    required this.comment,
    required this.replyComment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) {
    return CommentEntity(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      nickname: json['nickname'],
      profileImage: json['profileImage'],
      comment: json['comment'],
      replyComment: json['replyComment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  @override
  String toString() {
    return 'CommentEntity(id: $id, postId: $postId, userId: $userId, nickname: $nickname, profileImage: $profileImage, comment: $comment, replyComment: $replyComment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
