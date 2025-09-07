import 'package:equatable/equatable.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';

class HomeState extends Equatable {
  final HomeEntity? homeData;

  const HomeState({
    this.homeData,
  });

  HomeState copyWith({
    HomeEntity? homeData,
  }) {
    return HomeState(
      homeData: homeData ?? this.homeData,
    );
  }

  @override
  List<Object?> get props => [homeData];
}
