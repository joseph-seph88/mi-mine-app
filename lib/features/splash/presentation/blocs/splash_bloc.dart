import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/splash/presentation/blocs/splash_event.dart';
import 'package:mimine/features/splash/presentation/blocs/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashLoadingEvent>(_onSplashLoadingEvent);
    on<SplashLoadedEvent>(_onSplashLoadedEvent);
  }

  void _onSplashLoadingEvent(SplashLoadingEvent event, Emitter<SplashState> emit) {
    emit(SplashLoadingState());
  }

  void _onSplashLoadedEvent(SplashLoadedEvent event, Emitter<SplashState> emit) {
    emit(SplashLoadedState());
  }
}
