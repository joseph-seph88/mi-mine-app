import 'package:mimine/features/home/domain/entites/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getMyInfo();
}