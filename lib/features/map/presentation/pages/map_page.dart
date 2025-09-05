import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/features/map/presentation/widgets/map_search_bar_widget.dart';
import 'package:mimine/features/map/presentation/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          _buildMapSection(),
          _buildSearchSection(searchController, context),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return const Positioned.fill(child: MapWidget());
  }

  Widget _buildSearchSection(
      TextEditingController searchController, BuildContext context) {
    return Positioned(
      top: 58,
      left: 16,
      right: 16,
      child: MapSearchBarWidget(
        controller: searchController,
        hintText: "장소를 검색하세요",
        showFilter: true,
        filterCount: 0,
        // isReadOnly: true,
        // onTap: () {
        //   context.push(RouterPath.search);
        // },
      ),
    );
  }
}
