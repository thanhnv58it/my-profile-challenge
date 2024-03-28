import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:my_profile/data/repositories/abstract/user_repository.dart';
import 'package:my_profile/presentation/features/authentication/authentication_bloc.dart';
import 'package:my_profile/presentation/features/login/login_bloc.dart';
import 'package:my_profile/presentation/features/login/login_screen.dart';
import 'package:my_profile/presentation/features/home/home_screen.dart';
import 'package:my_profile/presentation/features/splash_screen.dart';
import 'locator.dart' as service_locator;
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(error.toString());
  }
}

void main() {
  service_locator.init();
  Bloc.observer = SimpleBlocDelegate();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: MultiRepositoryProvider(providers: [
      RepositoryProvider<UserRepository>(create: (context) => sl()),
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Profile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 128,
            height: 128,
            repeat: true,
            reverse: false,
            animate: true,
          ),
        );
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is Authenticated) {
          return const ProductScreen();
        } else if (state is Unauthenticated) {
          return _buildSignInBloc();
        } else {
          return const SplashScreen();
        }
      }),
    );
  }

  BlocProvider<LoginBloc> _buildSignInBloc() {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: const LoginScreen(),
    );
  }
}
