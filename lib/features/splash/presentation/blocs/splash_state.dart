import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashAuthSuccessState extends SplashState {}

class SplashAuthFailedState extends SplashState {}
