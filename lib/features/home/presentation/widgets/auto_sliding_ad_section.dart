import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/widgets/network_image_widget.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_state.dart';

class AutoSlidingAdSection extends StatelessWidget {
  const AutoSlidingAdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdCubit, AdState>(
      builder: (context, state) {
        final cubit = context.read<AdCubit>();
        return Column(
          children: [
            SizedBox(
              height: 200, 
              child: PageView.builder(
                controller: cubit.pageController,
                onPageChanged: cubit.onPageChanged,
                itemCount: state.adList.length,
                itemBuilder: (context, index) {
                  return _buildAdItem(index, state, cubit);
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(state.adList.length, (index) {
                final isActive = state.currentPage == index;
                return _buildAdIndicator(isActive);
              }),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAdItem(int index, AdState state, AdCubit cubit) {
    final adEntity = state.adList[index];
    final imageUrl = adEntity.imageUrl;
    final title = adEntity.title;
    final description = adEntity.description;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(8),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkImageWidget.networkImage(imageUrl: imageUrl),
          ],
        ),
      ),
    );
  }

  Widget _buildAdIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.grey.withAlpha(80),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
