import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';

class HomeUsecase {
  final HomeRepository _homeRepository;

  HomeUsecase(this._homeRepository);

  Future<HomeEntity> getMyInfo() async {
    return await _homeRepository.getMyInfo();
  }
}