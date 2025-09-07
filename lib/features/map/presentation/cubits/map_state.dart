import 'package:equatable/equatable.dart';

class MapState extends Equatable {
  final List<String> selectedFilters;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;

  const MapState(
      {this.selectedFilters = const [],
      this.isLoading = false,
      this.isError = false,
      this.isSuccess = false,
      this.errorMessage});

  MapState copyWith({List<String>? selectedFilters}) {
    return MapState(selectedFilters: selectedFilters ?? this.selectedFilters);
  }

  @override
  List<Object?> get props => [selectedFilters];
}
