import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashLoadingEvent extends SplashEvent {}

class SplashLoadedEvent extends SplashEvent {}

class SplashAuthSuccessEvent extends SplashEvent {}

class SplashAuthFailedEvent extends SplashEvent {}