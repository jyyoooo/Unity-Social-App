import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/constants/constants.dart';
import 'package:unitysocial/core/utils/validators.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/data/models/sign_up_model.dart';
import 'package:unitysocial/features/auth/screens/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.blocProvider,
  });

  final AuthBloc blocProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: blocProvider.signUpformKey,
          child: Column(
            children: [
              SizedBox.fromSize(
                size: const Size.fromHeight(60),
              ),
              CustomTextField(
                controller: context.read<AuthBloc>().nameController,
                hintText: 'Name',
                validator: isUsernameValid,
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
              CustomTextField(
                controller: context.read<AuthBloc>().confirmPasswordController,
                hintText: 'Confirm password',
                validator: isPasswordValid,
                obscureText: true,
              ),
              SizedBox.fromSize(
                size: const Size.fromHeight(25),
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoadingState) {
                    log('loading');
                  } else if (state is AuthSuccessState) {
                    log('auth suxs');
                    showSnackbar(context,
                        'Account created for ${blocProvider.nameController.text}, Login to Continue');
                    DefaultTabController.of(context).animateTo(1);
                    blocProvider.nameController.clear();
                    blocProvider.emailController.clear();
                    blocProvider.passwordController.clear();
                    blocProvider.confirmPasswordController.clear();
                  } else if (state is AuthErrorState) {
                    log('auth error');
                    showSnackbar(context, 'email already exists');
                  }
                },
                child: context.watch<AuthBloc>().state is AuthLoadingState
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        label: 'Sign Up',
                        onPressed: () {
                          log('signup working');
                          if (blocProvider.signUpformKey.currentState!
                                  .validate() &&
                              blocProvider.confirmPasswordController.text ==
                                  blocProvider.passwordController.text) {
                            final signUp = SignUpModel(
                                name: blocProvider.nameController.text.trim(),
                                email: blocProvider.emailController.text,
                                password: blocProvider.passwordController.text);

                            blocProvider.add(SignUpEvent(user: signUp));
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
