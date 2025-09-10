import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  NaverMapController? _mapController;
  // Map<String, dynamic>? _currentLatLng;
  double _currentZoom = 14;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _mapController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) async {
        if (state.selectedPlaceInfo != null &&
            state.selectedPlaceInfo?.latLng != null) {
          await _moveToCurrentLocation(latLng: state.selectedPlaceInfo?.latLng);
        }
      },
      builder: (context, state) => Stack(
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
              await _moveToCurrentLocation(isCurrentLocation: true);
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
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Future<void> _initData() async {
    await context.read<MapCubit>().getCurrentLocation();
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

  Future<void> _moveToCurrentLocation({
    Map<String, dynamic>? latLng,
    bool isCurrentLocation = false,
  }) async {
    if (_mapController == null) return;
    if (isCurrentLocation) {
      final latLng = context.read<MapCubit>().state.currentLatLng;
      final nLatLng = NLatLng(latLng!['lat'], latLng['lng']);
      await _mapController?.updateCamera(
        NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: nLatLng, zoom: _currentZoom),
        ),
      );
    } else {
      final nLatLng = NLatLng(latLng!['lat'], latLng['lng']);
      await _mapController?.updateCamera(
        NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: nLatLng, zoom: _currentZoom),
        ),
      );
    }
  }

  NaverMapViewOptions _getNaverMapViewOptions() {
    final currentLatLng = context.read<MapCubit>().state.currentLatLng;
    if (currentLatLng == null) {
      return NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.5547, 126.9706),
          zoom: _currentZoom,
        ),
      );
    }
    return NaverMapViewOptions(
      initialCameraPosition: NCameraPosition(
        target: NLatLng(currentLatLng['lat'], currentLatLng['lng']),
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
        onPressed: () => _moveToCurrentLocation(isCurrentLocation: true),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        mini: true,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
