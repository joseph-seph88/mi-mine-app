import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/features/home/presentation/cubits/ad_section_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/ad_section_state.dart';

class AutoSlidingAdSection extends StatelessWidget {
  const AutoSlidingAdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdSectionCubit(),
      child: const _AdSectionContent(),
    );
  }
}

class _AdSectionContent extends StatelessWidget {
  const _AdSectionContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdSectionCubit, AdSectionState>(
      builder: (context, state) {
        final cubit = context.read<AdSectionCubit>();

        return Column(
          children: [
            // 광고 캐러셀
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: cubit.pageController,
                onPageChanged: cubit.onPageChanged,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.8),
                          AppColors.primary.withOpacity(0.6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 배경 이미지 또는 색상
                          Container(
                            color: AppColors.primary.withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                Icons.campaign,
                                size: 60,
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                          ),
                          // 광고 내용
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '광고 ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '특별한 혜택을 확인해보세요!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 자동 슬라이딩 상태 표시
                          Positioned(
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: () {
                                if (state.isAutoSliding) {
                                  cubit.pauseAutoSlide();
                                } else {
                                  cubit.resumeAutoSlide();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  state.isAutoSliding
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // 페이지 인디케이터
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isActive = state.currentPage == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
