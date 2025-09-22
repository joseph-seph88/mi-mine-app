import 'package:equatable/equatable.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';

class AdState extends Equatable {
  final int currentPage;
  final bool isAutoSliding;
  final List<AdEntity> adList;

  const AdState({
    this.currentPage = 0,
    this.isAutoSliding = true,
    this.adList = const [],
  });

  AdState copyWith({
    int? currentPage,
    bool? isAutoSliding,
    List<AdEntity>? adList,
  }) {
    return AdState(
      currentPage: currentPage ?? this.currentPage,
      isAutoSliding: isAutoSliding ?? this.isAutoSliding,
      adList: adList ?? this.adList,
    );
  }

  @override
  List<Object?> get props => [currentPage, isAutoSliding, adList];
}
