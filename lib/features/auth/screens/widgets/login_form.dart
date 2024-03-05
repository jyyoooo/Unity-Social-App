import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/utils/constants/constants.dart';
import 'package:unitysocial/core/utils/validators.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/data/models/login_model.dart';
import 'package:unitysocial/features/auth/screens/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_text_field.dart';
import 'package:unitysocial/features/home/screens/home_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.blocProvider,
  });

  final AuthBloc blocProvider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: blocProvider.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox.fromSize(
              size: const Size.fromHeight(60),
            ),
            CustomTextField(
              controller: context.read<AuthBloc>().emailController,
              hintText: 'E-mail',
              validator: isEmailValid,
            ),
            ValueListenableBuilder(
              valueListenable: isObscure,
              builder: (context, value, _) => CustomTextField(
                controller: context.read<AuthBloc>().passwordController,
                hintText: 'Password',
                validator: isPasswordValid,
                obscureText: true,
                suffixIcon: true,
              ),
            ),
            SizedBox.fromSize(
              size: const Size.fromHeight(25),
            ),
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) => current is LoginSuccesState,
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  log('loading');
                } else if (state is LoginSuccesState) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } else if (state is AuthErrorState) {
                  log('login error');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.authStatus.name),
                    duration: const Duration(seconds: 3),
                  ));
                }
              },
              child: context.watch<AuthBloc>().state is AuthLoadingState
                  ? CircularProgressIndicator(
                      color: buttonGreen,
                    )
                  : CustomButton(
                      label: 'Log In',
                      onPressed: () {
                        if (blocProvider.loginFormKey.currentState!
                            .validate()) {
                          context.read<AuthBloc>().add(LoginEvent(Login(
                              email: blocProvider.emailController.text.trim(),
                              password: blocProvider.passwordController.text)));
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
