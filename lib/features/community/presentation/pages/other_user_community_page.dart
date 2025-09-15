import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';
import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/app_text_styles.dart';

class OtherUserCommunityPage extends StatefulWidget {
  final String userId;

  const OtherUserCommunityPage({super.key, required this.userId});

  @override
  State<OtherUserCommunityPage> createState() => _OtherUserCommunityPageState();
}

class _OtherUserCommunityPageState extends State<OtherUserCommunityPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<CommunityCubit>().loadOtherUserInfo(widget.userId);
    context.read<CommunityCubit>().loadOtherUserPostList(widget.userId);
    context.read<CommunityCubit>().isMyFriend(widget.userId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text('프로필', style: AppTextStyles.blackF18W700),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.black),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          final user = state.otherUserData;
          final userPosts = state.otherUserPostList;

          return Column(
            children: [
              _buildUserProfileSection(user ?? UserEntity()),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPostsGrid(userPosts ?? []),
                    _buildEmptyTab('태그된 게시글'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserProfileSection(UserEntity user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImageWidget.getNetworkImageProvider(
                    user.profileImage,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: _buildUserStats(user)),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.nickname ?? 'Unknown User',
                  style: AppTextStyles.blackF18W700,
                ),
                if (user.motto != null) ...[
                  const SizedBox(height: 4),
                  Text(user.motto!, style: AppTextStyles.greyF13),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<CommunityCubit, CommunityState>(
              builder: (context, state) {
                final isMyFriend = state.isMyFriend;

                return ElevatedButton(
                  onPressed: () => _followUser(user.userId ?? 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isMyFriend
                        ? AppColors.primary
                        : AppColors.grey.withAlpha(30),
                    foregroundColor: isMyFriend
                        ? AppColors.white
                        : AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text(isMyFriend ? '내 친구' : '친구 추가'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats(UserEntity user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('내 게시물', user.contentsCount?.toString() ?? '0'),
        _buildStatItem('내 친구', user.followers?.length.toString() ?? '0'),
        _buildStatItem('내 팔로워', user.friends?.length.toString() ?? '0'),
      ],
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(count, style: AppTextStyles.blackF18W700),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.greyF13),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.black,
        labelColor: AppColors.black,
        unselectedLabelColor: Colors.grey[600],
        tabs: const [
          Tab(icon: Icon(Icons.grid_on, size: 24)),
          Tab(icon: Icon(Icons.person_pin, size: 24)),
        ],
      ),
    );
  }

  Widget _buildPostsGrid(List<PostEntity> posts) {
    if (posts.isEmpty) {
      return _buildEmptyPosts();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 1,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _buildGridPostItem(posts[index]);
      },
    );
  }

  Widget _buildGridPostItem(PostEntity post) {
    return GestureDetector(
      onTap: () => _showPostDetail(post),
      child: Container(
        color: Colors.grey[200],
        child: post.imageUrl != null
            ? NetworkImageWidget.networkImage(
                imageUrl: post.imageUrl!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            : Container(
                color: Colors.grey[100],
                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
      ),
    );
  }

  Widget _buildEmptyTab(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_camera_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '아직 게시글이 없습니다',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPosts() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_camera_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            '게시글',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '아직 게시글이 없습니다',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('차단하기'),
              onTap: () {
                context.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('신고하기'),
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _followUser(int? userId) {
    context.read<CommunityCubit>().addMyFriend(userId?.toString() ?? '');
  }

  void _showPostDetail(PostEntity post) {
    context.pushNamed(
      RouterName.postDetail,
      pathParameters: {'postId': post.postId ?? ''},
    );
  }
}
