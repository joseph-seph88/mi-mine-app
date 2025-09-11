import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/mock/place_info_mock.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';

class MapBottomSheetWidget extends StatelessWidget {
  const MapBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight - 24;

    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Container(
          height: availableHeight * 0.7,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              _buildHandle(),
              _buildHeader(context, state),
              _buildFilterContent(context, state),
              _buildBottomButtons(context),
            ],
          ),
        );
      },
    );
  }

  void _toggleFilter(BuildContext context, String filter) {
    final cubit = context.read<MapCubit>();
    final currentFilters = List<String>.from(cubit.state.selectedFilters);

    if (currentFilters.contains(filter)) {
      currentFilters.remove(filter);
    } else {
      currentFilters.add(filter);
    }

    cubit.setSelectedFilters(currentFilters);
  }

  void _resetFilters(BuildContext context) {
    context.read<MapCubit>().resetSelectedFilters();
  }

  void _applyFilters(
    BuildContext context,
    Map<String, dynamic> latLng,
    List<String> placeType,
  ) async {
    context.pop();
    await context.read<MapCubit>().getPlaceInfoList(
      latLng,
      placeTypeKr: placeType,
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.white300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MapState state) {
    final selectedFilters = state.selectedFilters;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.white100],
        ),
        border: const Border(
          bottom: BorderSide(color: AppColors.white300, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('필터', style: AppTextStyles.blackF20W800LS),
          Row(
            children: [
              if (selectedFilters.isNotEmpty) ...[
                GestureDetector(
                  onTap: () => _resetFilters(context),
                  child: Text(
                    '초기화',
                    style: AppTextStyles.greyF13.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: selectedFilters.isNotEmpty
                      ? AppColors.primary.withAlpha(200)
                      : AppColors.white200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  selectedFilters.isNotEmpty
                      ? '${selectedFilters.length}개 선택'
                      : '선택 안함',
                  style: TextStyle(
                    color: selectedFilters.isNotEmpty
                        ? AppColors.white
                        : AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context, MapState state) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('카테고리', style: AppTextStyles.blackF16W700H12),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: PlaceInfoMock.filterCategories.length,
              itemBuilder: (context, index) {
                final category = PlaceInfoMock.filterCategories[index];
                return _buildCategoryCard(context, state, category);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    MapState state,
    Map<String, dynamic> category,
  ) {
    final categoryName = category['name'] as String;
    final icon = category['icon'] as IconData;
    final color = Color(category['color'] as int);
    final isSelected = state.selectedFilters.contains(categoryName);

    return GestureDetector(
      onTap: () => _toggleFilter(context, categoryName),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.white100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.white300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.white.withAlpha(51)
                    : color.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.white : color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              categoryName,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.grey,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: -0.1,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 44),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.white300, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _resetFilters(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: AppColors.white300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '초기화',
                style: AppTextStyles.greyF13.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                final state = context.read<MapCubit>().state;
                _applyFilters(
                  context,
                  state.displayLatLng ?? {},
                  state.selectedFilters,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary.withAlpha(200),
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                '필터 적용',
                style: AppTextStyles.blackF16W700H12.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
