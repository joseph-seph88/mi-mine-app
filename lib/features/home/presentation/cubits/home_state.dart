import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeDataState extends HomeState {
  final String data;
  final String? errorMessage;

  HomeDataState({
    required this.data,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [data, errorMessage];
}
