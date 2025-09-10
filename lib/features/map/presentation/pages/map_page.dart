import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/app/router/router_constants.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/features/map/presentation/widgets/map_bottom_sheet_widget.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';
import 'package:mimine/features/map/presentation/widgets/map_permission_dialog.dart';
import 'package:mimine/features/map/presentation/widgets/map_search_bar_widget.dart';
import 'package:mimine/features/map/presentation/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state.permissionStatusType ==
            PermissionStatusType.permissionDenied) {
          context.read<MapCubit>().checkRequestPermission();
        } else if (state.permissionStatusType ==
            PermissionStatusType.permissionPermanentlyDenied) {
          MapPermissionDialog.show(context, state);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: MapWidget()),
            Positioned(
              top: 58,
              left: 16,
              right: 16,
              child: BlocBuilder<MapCubit, MapState>(
                builder: (context, state) {
                  return MapSearchBarWidget(
                    hintText: "장소를 검색하세요",
                    filterCount: state.selectedFilters.length,
                    onFilterTap: () => _showFilterBottomSheet(context),
                    onTap: () => context.pushNamed(RouterName.search),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MapBottomSheetWidget(),
    );
  }

  // void _showFilterBottomSheet(
  //   BuildContext context,
  //   List<String> selectedFilters,
  // ) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => MapBottomSheetWidget(
  //       selectedFilters: selectedFilters,
  //       onFiltersChanged: (filters) {
  //         context.read<MapCubit>().setSelectedFilters(filters);
  //       },
  //       onApply: () {
  //         context.pop();
  //       },
  //       onReset: () {
  //         context.read<MapCubit>().resetSelectedFilters();
  //       },
  //     ),
  //   );
  // }
}
