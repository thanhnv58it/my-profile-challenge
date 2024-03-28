import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Uninitialized()) {
    on<AppStarted>(onAppStarted);
    on<LoggedIn>(onLoggedIn);
    on<LoggedOut>(onLoggedOut);
  }

  Future<void> onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
  }

  Future<void> onLoggedIn(
      LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Authenticated());
  }

  Future<void> onLoggedOut(
      LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
  }
}
