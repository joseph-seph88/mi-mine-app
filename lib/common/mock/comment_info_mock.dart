import 'package:mimine/common/entities/comment_entity.dart';

abstract class CommentInfoMock {
  static List<Map<String, dynamic>> get commentInfoJson => [
    {
      'id': '1',
      'postId': '1',
      'userId': '1',
      'nickname': 'John Doe',
      'profileImage': 'https://picsum.photos/150/150?random=1',
      'comment': 'This is a comment',
      'replyComment': '',
      'createdAt': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    },
    {
      'id': '2',
      'postId': '2',
      'userId': '2',
      'nickname': 'Jane Doe',
      'profileImage': 'https://picsum.photos/150/150?random=2',
      'comment': 'This is a comment',
      'replyComment': 'good',
      'createdAt': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
    },
  ];

  static List<CommentEntity> get commentDataList => <CommentEntity>[
    CommentEntity(
      id: '1',
      postId: '1',
      userId: 'user1',
      nickname: '사용자1',
      profileImage: '',
      comment: '정말 좋은 게시글이네요! 👍',
      replyComment: 'to do',
      createdAt: DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
      updatedAt: DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    ),
    CommentEntity(
      id: '2',
      postId: '2',
      userId: 'user2',
      nickname: '사용자2',
      profileImage: '',
      comment: '저도 비슷한 경험이 있어요. 공감됩니다!',
      replyComment: '',
      createdAt: DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
      updatedAt: DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
    ),
  ];
}
