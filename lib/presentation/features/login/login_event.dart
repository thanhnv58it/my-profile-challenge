part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GetSavedDataEvent extends LoginEvent {
  final Function(AppUser? user) onSuccess;

  const GetSavedDataEvent({required this.onSuccess});
}

class LoginPressedEvent extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginPressedEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [email, password, rememberMe];
}
