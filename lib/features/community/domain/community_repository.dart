import 'package:mimine/features/post/domain/entities/post_entity.dart';

abstract class CommunityRepository {
  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10});
}
