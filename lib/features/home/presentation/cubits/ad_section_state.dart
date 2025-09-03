import 'package:equatable/equatable.dart';

class AdSectionState extends Equatable {
  final int currentPage;
  final bool isAutoSliding;

  const AdSectionState({
    this.currentPage = 0,
    this.isAutoSliding = true,
  });

  AdSectionState copyWith({
    int? currentPage,
    bool? isAutoSliding,
  }) {
    return AdSectionState(
      currentPage: currentPage ?? this.currentPage,
      isAutoSliding: isAutoSliding ?? this.isAutoSliding,
    );
  }

  @override
  List<Object?> get props => [currentPage, isAutoSliding];
}
