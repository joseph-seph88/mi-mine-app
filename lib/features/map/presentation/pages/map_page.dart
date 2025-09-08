import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/widgets/app_bottom_sheet_widget.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';
import 'package:mimine/features/map/presentation/widgets/map_permission_dialog.dart';
import 'package:mimine/features/map/presentation/widgets/map_search_bar_widget.dart';
import 'package:mimine/features/map/presentation/widgets/map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _selectedFilters = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_buildMapSection(), _buildSearchSection()]),
    );
  }

  Widget _buildMapSection() {
    return const Positioned.fill(child: MapWidget());
  }

  Widget _buildSearchSection() {
    return Positioned(
      top: 58,
      left: 16,
      right: 16,
      child: MapSearchBarWidget(
        controller: _searchController,
        hintText: "장소를 검색하세요",
        showFilter: true,
        filterCount: _selectedFilters.length,
        onFilterTap: _showFilterBottomSheet,
        isReadOnly: true,
        onTap: () => context.push(RouterPath.search),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheetWidget(
        selectedFilters: _selectedFilters,
        onFiltersChanged: (filters) {
          setState(() {
            _selectedFilters = filters;
          });
        },
        onApply: () {
          context.pop();
        },
        onReset: () {},
      ),
    );
  }
}
