import 'package:catching_josh/catching_josh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mimine/common/constants/image_path.dart';
import 'package:mimine/common/styles/app_colors.dart';
import 'package:mimine/core/utils/debounce/debounce_util.dart';
import 'package:mimine/features/map/domain/enums/map_status_type.dart';
import 'package:mimine/features/map/presentation/cubits/map_cubit.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  NaverMapController? _mapController;
  final double _currentZoom = 14.0;
  bool _readyCameraIdle = false;
  final DebounceUtil _cameraIdleDebouncer = DebounceUtil();
  late MapCubit _mapCubit;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listener: (context, state) async {
        if (state.mapViewMode == MapViewMode.searchResult) {
          await _moveToCurrentLocation(latLng: state.selectedPlaceInfo?.latLng);
        } else if (state.mapViewMode == MapViewMode.filterApplied) {
          await _addCustomOverlays(
            NLatLng(
              state.displayLatLng['lat'] ?? 0,
              state.displayLatLng['lng'] ?? 0,
            ),
          );
        } else if (state.mapViewMode == MapViewMode.searchWithFilter) {
          await _moveToCurrentLocation(latLng: state.selectedPlaceInfo?.latLng);
          await _addCustomOverlays(
            NLatLng(
              state.displayLatLng['lat'] ?? 0,
              state.displayLatLng['lng'] ?? 0,
            ),
          );
        }
      },
      listenWhen: (previous, current) =>
          (previous.mapViewMode != current.mapViewMode &&
              current.mapViewMode != MapViewMode.idle) ||
          (previous.selectedPlaceInfo != current.selectedPlaceInfo &&
              current.mapViewMode != MapViewMode.idle) ||
          (previous.placeInfoList != current.placeInfoList &&
              current.mapViewMode == MapViewMode.filterApplied),

      child: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) => Stack(
          children: [
            NaverMap(
              options: _getNaverMapViewOptions(),
              onMapReady: (controller) async {
                _mapController = controller;
                if (_mapController == null) return;
                if (MapViewMode.idle == _mapCubit.state.mapViewMode) {
                  await _moveToCurrentLocation(isCurrentLocation: true);
                }

                final displayLatLng = await _getDisplayLatLng();
                _mapCubit.setDisplayLatLng(displayLatLng);

                if (_mapCubit.state.placeInfoList.isNotEmpty) {
                  await _addCustomOverlays(
                    NLatLng(
                      displayLatLng['lat'] ?? 0,
                      displayLatLng['lng'] ?? 0,
                    ),
                  );
                }
              },
              onCameraIdle: () async {
                if (_mapController != null && _readyCameraIdle) {
                  _cameraIdleDebouncer.callAsync(() async {
                    final displayLatLng = await _getDisplayLatLng();
                    _mapCubit.setDisplayLatLng(displayLatLng);
                  });
                }
              },
            ),
            _buildFloatingActionButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _initData() async {
    _mapCubit = context.read<MapCubit>();

    if (_mapCubit.state.currentLatLng.isEmpty) {
      await _mapCubit.getCurrentLocation();
    }

    if (_mapCubit.state.placeInfoList.isEmpty) {
      await _mapCubit.getPlaceInfoList(_mapCubit.state.currentLatLng);
    }
  }

  void _disposeData() {
    _cameraIdleDebouncer.dispose();
    _mapController = null;
    _mapCubit.setDisplayLatLng({});
    _mapCubit.setMapViewMode(MapViewMode.idle);
    _mapCubit.resetSelectedFilters();
    _mapCubit.resetPlaceInfoList();
  }

  Future<void> _addBasicOverlay(NLatLng nowLatLng) async {
    if (_mapController == null) return;
    final basicMarker = NMarker(id: 'marker-basic', position: nowLatLng);
    await _mapController!.addOverlay(basicMarker);
  }

  Future<void> _addCustomOverlays(NLatLng nowLatLng) async {
    if (_mapController == null) return;
    final placeInfoList = _mapCubit.state.placeInfoList;
    await _mapController!.clearOverlays();

    try {
      NOverlayImage? markerIcon = await _makeMarkerIcon();
      NOverlayCaption? caption = _makeMarkerCaption();
      final List<NMarker> markers = [];

      for (int i = 0; i < placeInfoList.length; i++) {
        try {
          final placeInfo = placeInfoList[i];
          if (placeInfo.latLng['lat'] == null ||
              placeInfo.latLng['lng'] == null) {
            continue;
          }

          final nLatLng = NLatLng(
            placeInfo.latLng['lat'],
            placeInfo.latLng['lng'],
          );

          final marker = NMarker(
            id: 'marker-${placeInfo.placeId}-$i',
            position: nLatLng,
            icon: markerIcon,
            size: const Size(40, 50),
            caption: caption,
          );
          markers.add(marker);
          print("마커 $i 생성 완료:: ${placeInfo.name}");
        } catch (e) {
          print("마커 $i 생성 실패: $e");
          continue;
        }
      }

      if (markers.isNotEmpty) {
        await _mapController!.addOverlayAll(markers.toSet());
        print("마커 ${markers.length}개 추가 완료");
      }
    } catch (e) {
      JoshLogger.singleLogLine("마커 추가 중 오류 발생: $e");
    }
  }

  Future<NOverlayImage?> _makeMarkerIcon() async {
    try {
      return NOverlayImage.fromAssetImage(ImagePath.appMarker);
    } catch (e) {
      return null;
    }
  }

  NOverlayCaption? _makeMarkerCaption() {
    return NOverlayCaption(
      text: 'MIMINE',
      color: Colors.white,
      haloColor: Colors.black,
      textSize: 10.0,
    );
  }

  Future<void> _moveToCurrentLocation({
    Map<String, dynamic>? latLng,
    bool isCurrentLocation = false,
  }) async {
    if (_mapController == null) return;
    if (isCurrentLocation) {
      final latLng = _mapCubit.state.currentLatLng;
      final nLatLng = NLatLng(latLng['lat'], latLng['lng']);
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
    _readyCameraIdle = true;
  }

  NaverMapViewOptions _getNaverMapViewOptions() {
    final currentLatLng = _mapCubit.state.currentLatLng;
    if (currentLatLng.isEmpty) {
      return NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.5547, 126.9706),
          zoom: 14.0,
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

  Future<Map<String, dynamic>> _getDisplayLatLng() async {
    if (_mapController == null) return {};
    final nowCameraPosition = await _mapController!.getCameraPosition();
    final displayLatLng = {
      'lat': nowCameraPosition.target.latitude,
      'lng': nowCameraPosition.target.longitude,
    };
    return displayLatLng;
  }
}
