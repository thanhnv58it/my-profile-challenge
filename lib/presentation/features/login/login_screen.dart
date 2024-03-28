import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_profile/config/theme.dart';
import 'package:my_profile/presentation/features/login/login_bloc.dart';
import 'package:my_profile/presentation/widgets/independent/custom_button.dart';
import 'package:my_profile/presentation/widgets/independent/error_dialog.dart';
import 'package:my_profile/presentation/widgets/independent/input_field.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<BasicTextFieldState> _formEmailKey = GlobalKey();
  final GlobalKey<BasicTextFieldState> _formPasswordKey = GlobalKey();
  var rememberMe = false;

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context)
        .add(GetSavedDataEvent(onSuccess: (user) {
      if (user != null) {
        _emailController.text = user.username;
        _passwordController.text = user.password;
        rememberMe = true;
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginProcessingState) {
            context.loaderOverlay.show();
          } else if (state is LoginErrorState) {
            ErrorDialog.showErrorDialog(context, state.error);
          } else {
            context.loaderOverlay.hide();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animations/login.json',
                      width: 200,
                      height: 200,
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),
                  ),
                  BasicTextField(
                    key: _formEmailKey,
                    controller: _emailController,
                    labelText: 'Enter your Username',
                    isSecure: false,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'abc@xyz.com',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  BasicTextField(
                    key: _formPasswordKey,
                    controller: _passwordController,
                    labelText: "Enter your Password",
                    isSecure: true,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: '********',
                    prefixIcon: const Icon(Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Checkbox(
                          value:
                              rememberMe, // Change this to your desired value
                          onChanged: (newValue) {
                            setState(() {
                              rememberMe = newValue ?? false;
                            });
                          },
                        ),
                        const Text('Remember me'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  OpenFlutterButton(
                      title: 'LOGIN', onPressed: _validateAndSend),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _validateAndSend() {
    if (_formEmailKey.currentState?.validate() != null) {
      return;
    }

    if (_formPasswordKey.currentState?.validate() != null) {
      return;
    }
    BlocProvider.of<LoginBloc>(context).add(
      LoginPressedEvent(
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: rememberMe,
      ),
    );
  }
}
