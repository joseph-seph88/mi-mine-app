import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';
import 'package:mimine/features/home/presentation/widgets/auto_sliding_ad_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child:
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return _buildHeaderSection(state.homeData);
          })),
          SliverToBoxAdapter(child: _buildAdSection()),
          SliverToBoxAdapter(child:
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return _buildBestContentSection(state.bestContents);
          })),
          SliverToBoxAdapter(child:
              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return _buildAllContentSection(state.allContents);
          })),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(HomeEntity? homeData) {
    final nickname = homeData?.nickname;
    final profileImage = homeData?.profileImage;
    final motto = homeData?.motto;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.grey.withAlpha(51),
                backgroundImage:
                    profileImage != null ? NetworkImage(profileImage) : null,
                child: profileImage == null
                    ? const Icon(
                        Icons.person,
                        size: 32,
                        color: AppColors.grey,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nickname ?? 'JOSEPH88',
                      style: AppTextStyles.blackF20W800LS,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        motto ?? 'THIS MOMENT',
                        style: AppTextStyles.primaryF13W600LS,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.add_rounded,
                        color: AppColors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: AppColors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: AppColors.grey.withAlpha(25),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem('내 작품', '12개'),
              _buildStatDivider(),
              _buildStatItem('라이크', '1.2K'),
              _buildStatDivider(),
              _buildStatItem('팔로워', '89명'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.blackF18W700),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.greyWA178F12),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.grey.withAlpha(51),
    );
  }

  Widget _buildAdSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 28, 18, 16),
          child: Text('Trending Now', style: AppTextStyles.blackF24W700H135),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
          child: const AutoSlidingAdSection(),
        ),
      ],
    );
  }

  Widget _buildBestContentSection(List<Map<String, dynamic>> bestContents) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Featured Works', style: AppTextStyles.blackF24W700H135),
      ),
      SizedBox(
        height: 320,
        child: PageView.builder(
          itemCount: bestContents.length,
          controller: PageController(viewportFraction: 0.85),
          padEnds: false,
          itemBuilder: (context, index) {
            final bestContent = bestContents[index];
            final imageUrl = bestContent['imageUrl'];
            final title = bestContent['title'];
            final description = bestContent['description'];

            return Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: 8,
                top: 16,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      color: AppColors.lightGrey,
                      child:
                          NetworkImageWidget.networkImage(imageUrl: imageUrl),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title.isNotEmpty ? title : '멋진 작품 제목이 여기에 표시됩니다',
                    style: AppTextStyles.blackF16W700H12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description.isNotEmpty
                        ? description
                        : '이것은 작품에 대한 상세한 설명입니다. 작가의 의도와 작품의 의미를 담은 아름다운 텍스트가 여기에 표시됩니다.',
                    style: AppTextStyles.greyWA204F13W400H13,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      )
    ]);
  }

  Widget _buildAllContentSection(List<Map<String, dynamic>> allContents) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('My Gallery', style: AppTextStyles.blackF24W700H135),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 12,
            mainAxisSpacing: 2,
          ),
          itemCount: allContents.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final allContent = allContents[index];
            final imageUrl = allContent['imageUrl'];
            final title = allContent['title'];
            final description = allContent['description'];

            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withAlpha(4),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        color: AppColors.lightGrey,
                        child:
                            NetworkImageWidget.networkImage(imageUrl: imageUrl),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title.isNotEmpty ? title : '멋진 작품',
                      style: AppTextStyles.blackF14W700H12,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description.isNotEmpty ? description : '작품 설명',
                      style: AppTextStyles.greyWA204F12W400H13,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    ]);
  }
}
