part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginProcessingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  const LoginErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class LoginFinishedState extends LoginState {}
