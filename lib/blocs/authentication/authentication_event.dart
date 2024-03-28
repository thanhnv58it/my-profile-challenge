part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  LoggedIn();

  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthenticationEvent {}
