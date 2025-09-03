import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/presentation/cubits/ad_section_state.dart';

class AdSectionCubit extends Cubit<AdSectionState> {
  Timer? _timer;
  late PageController _pageController;

  AdSectionCubit() : super(const AdSectionState()) {
    _pageController = PageController();
    _startAutoSlide();
  }

  PageController get pageController => _pageController;

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _nextPage();
    });
  }

  void _nextPage() {
    final currentPage = _pageController.page?.round() ?? 0;
    final nextPage = (currentPage + 1) % 5; // 5개의 광고 페이지

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
