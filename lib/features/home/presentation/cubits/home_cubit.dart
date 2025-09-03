import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/presentation/cubits/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void homeLoading() {
    emit(HomeLoadingState());
  }

  void loadDataSuccess() {
    emit(HomeDataState(data: 'Home data loaded successfully!'));
  }

}
