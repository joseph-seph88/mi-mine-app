import 'package:mimine/features/community/domain/community_repository.dart';
import 'package:mimine/features/post/domain/entities/post_entity.dart';

class CommunityUsecase {
  final CommunityRepository _communityRepository;

  CommunityUsecase(this._communityRepository);

  Future<List<PostEntity>> getAllPosts({int page = 1, int size = 10}) async {
    return await _communityRepository.getAllPosts(page: page, size: size);
  }
}