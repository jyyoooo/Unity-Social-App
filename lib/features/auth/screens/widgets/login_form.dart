import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/data/models/login_model.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_text_field/unity_text_field.dart';
import 'package:unitysocial/features/donation/bloc/donation_button_cubit.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bar.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.blocProvider,
  });

  final AuthBloc blocProvider;
  final loginFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox.fromSize(
                size: const Size.fromHeight(60),
              ),
              UnityTextField(
                  controller: blocProvider.emailController,
                  hintText: 'E-mail',
                  validator: emailValidation),
              UnityTextField(
                  obscure: true,
                  controller: passwordController,
                  hintText: 'Password',
                  validator: passwordValidation),
              BlocListener<AuthBloc, AuthState>(
                // listenWhen: (previous, current) => current is LoginSuccesState,
                listener: (context, state) {
                  if (state is AuthLoadingState) {
                    log('loading');
                  } else if (state is LoginSuccesState) {
                    log('login suxs');
                    showSnackbar(context, 'Logged in as ${state.userName}',
                        CupertinoColors.systemTeal.highContrastColor);
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const UnityNavigator()));
                  }
                  if (state is AuthErrorState) {
                    log('login error');
                    showSnackbar(context, 'Invalid login credentials',
                        CupertinoColors.systemRed);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: context.watch<AuthBloc>().state is AuthLoadingState
                      ? CustomButton(
                          loading: true,
                          onPressed: () =>
                              context.read<ButtonCubit>().stopLoading())
                      : CustomButton(
                          label: 'Log In',
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(LoginEvent(Login(
                                  email:
                                      blocProvider.emailController.text.trim(),
                                  password: passwordController.text.trim())));
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
