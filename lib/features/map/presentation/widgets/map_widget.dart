import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mimine/common/constants/image_path.dart';
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
  final double _currentZoom = 14.0;
  bool _readyCameraIdle = false;

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

        if (state.placeInfoList != null && state.placeInfoList!.isNotEmpty) {
          final displayLatLng = NLatLng(
            state.displayLatLng?['lat'] ?? 0,
            state.displayLatLng?['lng'] ?? 0,
          );
          print("스테이트 두번째 레슨");
          await _addOverlays(displayLatLng);
        }
      },
      listenWhen: (previous, current) {
        return previous.placeInfoList != current.placeInfoList ||
            previous.selectedPlaceInfo != current.selectedPlaceInfo;
      },
      builder: (context, state) => Stack(
        children: [
          NaverMap(
            options: _getNaverMapViewOptions(),
            onMapReady: (controller) async {
              _mapController = controller;
              if (_mapController == null) return;
              await _moveToCurrentLocation(isCurrentLocation: true);
              final nowCameraPosition = await controller.getCameraPosition();
              final displayLatLng = {
                'lat': nowCameraPosition.target.latitude,
                'lng': nowCameraPosition.target.longitude,
              };

              if (!context.mounted) return;
              context.read<MapCubit>().setDisplayLatLng(displayLatLng);
            },
            onCameraIdle: () async {
              if (_mapController != null && _readyCameraIdle) {
                final nowCameraPosition = await _mapController!
                    .getCameraPosition();
                final displayLatLng = {
                  'lat': nowCameraPosition.target.latitude,
                  'lng': nowCameraPosition.target.longitude,
                };
                if (!context.mounted) return;
                context.read<MapCubit>().setDisplayLatLng(displayLatLng);
              }
            },
          ),
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Future<void> _initData() async {
    await context.read<MapCubit>().getCurrentLocation();
    if (!mounted) return;
    await context.read<MapCubit>().getPlaceInfoList(
      context.read<MapCubit>().state.currentLatLng ?? {},
    );
  }

  Future<void> _addOverlays(NLatLng nowLatLng) async {
    if (_mapController == null) return;
    final placeInfoList = context.read<MapCubit>().state.placeInfoList;
    await _mapController!.clearOverlays();

    try {
      NOverlayImage? markerIcon = await _makeMarkerIcon();
      NOverlayCaption? caption = _makeMarkerCaption();
      final List<NMarker> markers = [];

      if (placeInfoList == null || placeInfoList.isEmpty) {
        final marker = NMarker(
          id: 'marker-current-${DateTime.now().millisecondsSinceEpoch}',
          position: nowLatLng,
          icon: markerIcon,
          size: const Size(40, 50),
          caption: caption,
        );
        markers.add(marker);
      } else {
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
      }
      if (markers.isNotEmpty) {
        await _mapController!.addOverlayAll(markers.toSet());
        print("마커 ${markers.length}개 추가 완료");
      }
    } catch (e) {
      print("마커 추가 중 오류 발생: $e");
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
    _readyCameraIdle = true;
  }

  NaverMapViewOptions _getNaverMapViewOptions() {
    final currentLatLng = context.read<MapCubit>().state.currentLatLng;
    if (currentLatLng == null) {
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
}
