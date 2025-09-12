import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/common/styles/app_text_styles.dart';
import 'package:mimine/common/widgets/text_highlight_widget.dart';
import 'package:mimine/common/widgets/app_logo.dart';
import 'package:mimine/features/map/domain/entities/search_entity.dart';
import 'package:mimine/features/map/domain/enums/map_status_type.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';
import 'package:mimine/core/utils/validators/form_validators.dart';
import 'package:mimine/core/utils/debounce/debounce_util.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final DebounceUtil _searchDebouncer = DebounceUtil();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _searchDebouncer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black5,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField()),
                  ],
                ),
              ),
              Expanded(
                child: state.isSearching
                    ? _buildSearchResults(state.placePredictions ?? [], state)
                    : state.recentSearches.isEmpty
                    ? _buildEmptyRecentSearches()
                    : _buildRecentSearches(state.recentSearches),
              ),
            ],
          ),
        );
      },
    );
  }

  void initData() async {
    await context.read<MapCubit>().getRecentSearches();
  }

  void _onSearchChanged(String value) {
    final searchText = value.trim();
    context.read<MapCubit>().setIsSearching(searchText.isNotEmpty);

    if (searchText.isNotEmpty &&
        FormValidators.hasCompleteKoreanCharacters(searchText)) {
      _searchDebouncer.callAsync(() async {
        if (mounted) {
          await context.read<MapCubit>().searchPlaces(searchText);
        }
      });
    } else if (searchText.isEmpty) {
      _searchDebouncer.cancel();
      if (mounted) {
        context.read<MapCubit>().clearPlacePredictions();
      }
    }
  }

  void _clearTextController() {
    if (!mounted) return;
    _searchDebouncer.cancel();
    _searchController.clear();
    context.read<MapCubit>().setIsSearching(false);
    context.read<MapCubit>().clearPlacePredictions();
  }

  Widget _buildTextField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.white200,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white300, width: 1),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _onSearchChanged(value);
        },
        decoration: InputDecoration(
          hintText: '장소를 검색해보세요',
          hintStyle: AppTextStyles.searchHintF16,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.grey,
            size: 20,
          ),
          suffixIcon: IconButton(
            onPressed: _clearTextController,
            icon: Icon(Icons.clear_outlined, size: 20, color: AppColors.grey),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
        style: AppTextStyles.searchTextF16W500,
      ),
    );
  }

  Widget _buildSearchResults(
    List<SearchEntity> placePredictions,
    MapState state,
  ) {
    return placePredictions.isEmpty
        ? _buildEmptySearchResults()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: placePredictions.length,
            itemBuilder: (context, index) {
              final prediction = placePredictions[index];
              final searchText = _searchController.text.trim();
              final mapCubit = context.read<MapCubit>();
              final placeId = prediction.placeId;

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    mapCubit.setIsSearching(false);
                    context.goNamed(RouterName.map);

                    await mapCubit.getPlaceDetails(placeId);
                    await mapCubit.setRecentSearchText(prediction.primaryText);
                    if (mapCubit.state.selectedFilters.isEmpty) {
                      mapCubit.setMapViewMode(MapViewMode.searchResult);
                    } else {
                      mapCubit.setMapViewMode(MapViewMode.searchWithFilter);
                      await mapCubit.getPlaceInfoList(
                        prediction.latLng ?? {},
                        placeTypeKr: state.selectedFilters,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextHighlightWidget.highlight(
                                searchText,
                                prediction.primaryText,
                              ),
                              if (prediction.secondaryText != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  prediction.secondaryText!,
                                  style: AppTextStyles
                                      .searchResultSecondaryF14W400,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildRecentSearches(List<String> recentSearches) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('최근 검색어', style: AppTextStyles.recentSearchTitleF20W800LS),
              if (recentSearches.isNotEmpty)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      await context.read<MapCubit>().removeAllRecentSearch();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text('모두 삭제', style: AppTextStyles.deleteAllF12W500),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: recentSearches.map((data) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    _searchController.text = data;
                    _onSearchChanged(data);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.white300, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data,
                          style: AppTextStyles.recentSearchItemF14W600,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            await context
                                .read<MapCubit>()
                                .removeOneRecentSearch(data);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.white300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 12,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyRecentSearches() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          const SizedBox(height: 20),
          Text('최근 검색어가 없습니다', style: AppTextStyles.emptyStateTitleF18W600),
          const SizedBox(height: 8),
          Text(
            '검색 후 최근 검색어에 추가됩니다',
            style: AppTextStyles.emptyStateSubtitleF14,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.white200,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search_off, size: 30, color: AppColors.grey),
          ),
          const SizedBox(height: 20),
          Text('검색 결과가 없습니다', style: AppTextStyles.emptyStateTitleF18W600),
          const SizedBox(height: 8),
          Text('다른 키워드로 검색해보세요', style: AppTextStyles.emptyStateSubtitleF14),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmallLogoWidget(
            size: 60,
            text: "MIMINE-JOSEPH",
            backgroundColor: AppColors.primary,
            iconColor: AppColors.primary,
            iconSize: 30,
            borderColor: AppColors.primary,
            textColor: AppColors.primary,
            fontSize: 8,
          ),
        ],
      ),
    );
  }
}
