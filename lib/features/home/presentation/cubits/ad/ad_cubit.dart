import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/ad/ad_state.dart';

class AdCubit extends Cubit<AdState> {

  final HomeUsecase _homeUsecase;
  Timer? _timer;
  late PageController _pageController;

  AdCubit(this._homeUsecase) : super(const AdState()) {
    _pageController = PageController();
    _startAutoSlide();
  }
  
  Future<void> loadAdInfoData() async {
    final adList = await _homeUsecase.getAdInfo();
    emit(state.copyWith(adList: adList));
  }

  PageController get pageController => _pageController;

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _nextPage();
    });
  }

  void _nextPage() {
    if (!_pageController.hasClients) {
      return;
    }

    final currentPage = _pageController.page?.round() ?? 0;
    final nextPage = (currentPage + 1) % 5;

    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentPage: nextPage));
  }

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void pauseAutoSlide() {
    _timer?.cancel();
    emit(state.copyWith(isAutoSliding: false));
  }

  void resumeAutoSlide() {
    if (!state.isAutoSliding) {
      _startAutoSlide();
      emit(state.copyWith(isAutoSliding: true));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _pageController.dispose();
    return super.close();
  }
}
