import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';
import 'package:mimine/features/map/presentation/widgets/map_permission_dialog.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  NaverMapController? _mapController;
  NLatLng? _currentLatLng;
  double _currentZoom = 14;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _mapController = null;
    super.dispose();
  }

  void _initialize() async {
    await context.read<MapCubit>().checkRequestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) {
        if (state.permissionStatusType ==
                PermissionStatusType.permissionDenied ||
            state.permissionStatusType ==
                PermissionStatusType.permissionPermanentlyDenied) {
          MapPermissionDialog.show(context, state);
        }
      },
      child: Stack(
        children: [
          NaverMap(
            options: _getNaverMapViewOptions(),
            onMapReady: (controller) async {
              _mapController = controller;
              // if (_isDisposed) return;
              // try {
              //   _mapController = controller;

              //   if (widget.showMarker) {
              //     await _addOverlays(controller, state);
              //     await _moveToCurrentLocation(state);
              //   }
              // } catch (e) {}
            },
            onCameraIdle: () {
              // if (_mapController != null) {
              //   try {
              //     final position = _mapController!.nowCameraPosition;
              //   } catch (e) {
              //   }
              // }
            },
          ),
          // if (widget.showFloatingActionButton) _buildFloatingActionButton(state),
        ],
      ),
    );
  }

  void _initializeDatas() {
    // if (!_isDisposed) {
    //   context.read<MapCubit>().getCurrentLocation();
    // }
  }

  void _cleanupResources() {
    // try {
    //   _mapController = null;
    // } catch (e) {
    //   logger.e('[OnMap] 리소스 정리 중 오류: $e');
    // }
  }

  Future<void> _addOverlays(NaverMapController controller) async {
    // try {
    //   final nLatLng = state.currentLocation;

    //   NOverlayImage? markerIcon = await _makeMarkerIcon();
    //   NLatLng latLng =
    //       nLatLng != const NLatLng(0, 0) ? nLatLng : NLatLng(37.5547, 126.9706);
    //   Size size = widget.markerEntity?.size ?? const Size(40, 50);
    //   NOverlayCaption? caption = _makeMarkerCaption();

    //   final marker = NMarker(
    //     id: 'basicMarker-${DateTime.now().millisecondsSinceEpoch}',
    //     position: latLng,
    //     icon: markerIcon,
    //     size: size,
    //     caption: caption,
    //   );

    //   try {
    //     await controller.addOverlay(marker);
    //   } catch (e) {
    //     logger.e('[OnMap] 마커 추가 실패: $e');
    //   }
    // } catch (e) {
    //   logger.e('[OnMap] 오버레이 추가 실패 :: $e');
    // }
  }

  Future<NOverlayImage?> _makeMarkerIcon() async {
    // try {
    //   if (widget.markerEntity != null &&
    //       widget.markerEntity!.imagePath != null) {
    //     return NOverlayImage.fromAssetImage(widget.markerEntity!.imagePath!);
    //   } else {
    //     return null;
    //   }
    // } catch (e) {
    //   logger.e('[OnMap] 마커 아이콘 생성 실패: $e');
    //   return null;
    // }
  }

  NOverlayCaption? _makeMarkerCaption() {
    // if (widget.markerEntity != null) {
    //   return NOverlayCaption(
    //     text: widget.markerEntity!.text ?? '',
    //     color: widget.markerEntity!.captionColor ?? Colors.white,
    //     haloColor: widget.markerEntity!.haloColor ?? Colors.black,
    //     textSize: widget.markerEntity!.textSize ?? 12.0,
    //   );
    // } else {
    //   return NOverlayCaption(text: '');
    // }
  }

  Future<void> _moveToCurrentLocation() async {
    if (_mapController != null && _currentLatLng != null) {
      await _mapController?.updateCamera(
        NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: _currentLatLng!, zoom: _currentZoom),
        ),
      );
    }
  }

  NaverMapViewOptions _getNaverMapViewOptions() {
    return NaverMapViewOptions(
      initialCameraPosition: NCameraPosition(
        target: _currentLatLng ?? NLatLng(37.5547, 126.9706),
        zoom: _currentZoom,
      ),
      minZoom: 10.0,
      maxZoom: 18.0,
      consumeSymbolTapEvents: true,
      logoAlign: NLogoAlign.leftBottom,
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 5,
      bottom: 50,
      child: FloatingActionButton(
        onPressed: () => _moveToCurrentLocation(),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        mini: true,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
