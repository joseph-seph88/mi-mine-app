import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/auth/presentation/blocs/auth_event.dart';
import 'package:mimine/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthSuccessEvent>(_onAuthSuccessEvent);
  }

  void _onAuthSuccessEvent(AuthSuccessEvent event, Emitter<AuthState> emit) {
    emit(AuthSuccessState());
  }
}
