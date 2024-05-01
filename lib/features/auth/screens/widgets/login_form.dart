import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/utils/validators/validators.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/data/models/login_model.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_text_field/unity_text_field.dart';
import 'package:unitysocial/features/auth/data/repository/password_sevice.dart';
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
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    _passwordResetSheet(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: CupertinoColors.systemGrey, fontSize: 13),
                    ),
                  ),
                ),
              ),
              BlocListener<AuthBloc, AuthState>(
                // listenWhen: (previous, current) => current is LoginSuccesState,
                listener: (context, state) {
                  if (state is AuthLoadingState) {
                    log('loading');
                  } else if (state is LoginSuccesState) {
                    log('login suxs');
                    showSnackbar(
                        context,
                        'Logged in as ${state.userName}',
                        CupertinoColors.systemTeal.highContrastColor,
                        Durations.extralong2);
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

  // Refactored widgets

  Future<dynamic> _passwordResetSheet(BuildContext context) {
    TextEditingController resetEmailController = TextEditingController();
    final resetPasswordFormKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxHeight: 580,
      ),
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: resetPasswordFormKey,
              child: ListView(
                children: [
                  const Text(
                    'Send a mail to reset your password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  UnityTextField(
                    hintText: 'Enter your mail address',
                    validator: emailValidation,
                    controller: resetEmailController,
                  ),
                  CustomButton(
                    padding: const EdgeInsets.only(top: 20),
                    label: 'Reset Password',
                    onPressed: () async {
                      if (resetPasswordFormKey.currentState!.validate()) {
                        await PasswordResetService()
                            .sendPasswordResetEmail(resetEmailController.text);
                      }

                      showSnackbar(
                          context,
                          'A link to reset your password has been sent. Please check your mail.',
                          CupertinoColors.systemTeal.highContrastColor);
                    },
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    'Check your mail after pressing Reset Password button. If we are able to find an account related to the mail address you provided you will recieve a mail to reset your password. After creating a new password, log in to Unity Social again.',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  // const Text(
                  //   'If you didnt recieve any mails, contactprofile us describing your issue in detail',
                  //   style: TextStyle(color: Colors.grey, fontSize: 11),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
