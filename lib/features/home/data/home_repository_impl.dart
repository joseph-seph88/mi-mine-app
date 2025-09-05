import 'package:mimine/core/services/my_info_service.dart';
import 'package:mimine/features/home/domain/entites/home_entity.dart';
import 'package:mimine/features/home/domain/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final MyInfoService _myInfoService;

  HomeRepositoryImpl(this._myInfoService);

  @override
  Future<HomeEntity> getMyInfo() async {
    final response = await _myInfoService.getMyInfo();
    return HomeEntity.fromJson(
        response.data, response.statusMessage, response.isSuccess ?? false);
  }
}
