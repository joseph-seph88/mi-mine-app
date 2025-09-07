import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/map/presentation/cubits/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  void setSelectedFilters(List<String> filters) {
    emit(state.copyWith(selectedFilters: filters));
  }
}