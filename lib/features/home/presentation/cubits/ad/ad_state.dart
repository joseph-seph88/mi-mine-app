import 'package:equatable/equatable.dart';
import 'package:mimine/features/home/domain/entites/ad_entity.dart';

class AdState extends Equatable {
  final int currentPage;
  final bool isAutoSliding;
  final List<AdEntity> adList;

  const AdState({
    this.currentPage = 0,
    this.isAutoSliding = true,
    this.adList = const [
      AdEntity(
        imageUrl: 'https://picsum.photos/400/200?random=1',
        title: '광고 1',
        description: '광고 1 설명',
      ),
      AdEntity(
        imageUrl: 'https://picsum.photos/400/200?random=2',
        title: '광고 2',
        description: '광고 2 설명',
      ),
      AdEntity(
        imageUrl: 'https://picsum.photos/400/200?random=3',
        title: '광고 3',
        description: '광고 3 설명',
      ),
      AdEntity(
        imageUrl: 'https://picsum.photos/400/200?random=4',
        title: '광고 4',
        description: '광고 4 설명',
      ),
      AdEntity(
        imageUrl: 'https://picsum.photos/400/200?random=5',
        title: '광고 5',
        description: '광고 5 설명',
      ),
    ],
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
