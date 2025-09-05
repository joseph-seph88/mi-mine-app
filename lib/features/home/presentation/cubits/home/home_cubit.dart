import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _homeUsecase;

  HomeCubit(this._homeUsecase) : super(HomeState());

  Future<void> loadDataSuccess() async {
    final response = await _homeUsecase.getMyInfo();

    emit(state.copyWith(homeData: response));
  }
}
