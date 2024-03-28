import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_profile/data/model/app_user.dart';
import 'package:my_profile/data/repositories/abstract/user_repository.dart';
import 'package:my_profile/presentation/features/authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<GetSavedDataEvent>(getSavedDataEvent);
    on<LoginPressedEvent>(loginPressed);
  }

  Future<void> getSavedDataEvent(
      GetSavedDataEvent event, Emitter<LoginState> emit) async {
    emit(LoginProcessingState());

    final user = await userRepository.getSavedUserData();
    event.onSuccess(user);
    emit(LoginInitial());
  }

  Future<void> loginPressed(
      LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginProcessingState());
    await Future.delayed(const Duration(seconds: 2));
    if (event.rememberMe) {
      userRepository.saveUserData(email: event.email, password: event.password);
    } else {
      userRepository.deleteUserData();
    }

    authenticationBloc.add(LoggedIn());
    emit(LoginFinishedState());
  }
}
