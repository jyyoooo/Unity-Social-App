import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/data/models/sign_up_model.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_text_field/unity_text_field.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key, required this.blocProvider});

  final AuthBloc blocProvider;
  final signUpformKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: signUpformKey,
            child: Column(
              children: [
                SizedBox.fromSize(
                  size: const Size.fromHeight(60),
                ),
                UnityTextField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: nameValidation,
                ),
                UnityTextField(
                  controller: blocProvider.emailController,
                  hintText: 'E-mail',
                  validator: emailValidation,
                ),
                UnityTextField(
                  obscure: true,
                  controller: passwordController,
                  hintText: 'Password',
                  validator: passwordValidation,
                ),
                UnityTextField(
                  obscure: true,
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  validator: (value) {
                    return confirmPassValidation(
                        value, passwordController.text);
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      log('loading');
                    } else if (state is AuthSuccessState) {
                      log('auth suxs');
                      showSnackbar(context,
                          'Account created for ${nameController.text}, Login to Continue');
                      DefaultTabController.of(context).animateTo(1);
                      nameController.clear();
                      blocProvider.emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                    } else if (state is AuthErrorState) {
                      log('auth error');
                      showSnackbar(context, 'email already exists');
                    }
                  },
                  child: context.watch<AuthBloc>().state is AuthLoadingState
                      ? const CircularProgressIndicator()
                      : Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: CustomButton(
                            label: 'Sign Up',
                            onPressed: () {
                              log('signup working');
                              if (signUpformKey.currentState!.validate() &&
                                  confirmPasswordController.text ==
                                      passwordController.text) {
                                final signUp = SignUpModel(
                                    name: nameController.text.trim(),
                                    email: blocProvider.emailController.text,
                                    password: passwordController.text);
                        
                                blocProvider.add(SignUpEvent(user: signUp));
                              }
                            },
                          ),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
