import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/utils/constants/constants.dart';
import 'package:unitysocial/core/utils/validators.dart';
import 'package:unitysocial/features/auth_feature/data/models/sign_up_model.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/custom_button.dart';
import 'widgets/unity_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: blocProvider.signUpformKey,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 25),
                    child: SvgPicture.asset(
                      'assets/UnitySocial-logo.svg',
                    )),
                Text(
                  'Unity',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: darkGreen),
                ),
                const Text('Social volunteering app',
                    style: TextStyle(
                      fontSize: 18,
                    )),
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
                  controller:
                      context.read<AuthBloc>().confirmPasswordController,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SizedBox()));
                    } else if (state is AuthErrorState) {
                      log('auth error');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.authStatus.name),
                        duration: const Duration(seconds: 3),
                      ));
                    }
                  },
                  child: CustomButton(
                    label: 'Login',
                    onPressed: () {
                      log('signup pressed');

                      if (blocProvider.signUpformKey.currentState!.validate() &&
                          blocProvider.confirmPasswordController.text ==
                              blocProvider.passwordController.text) {
                        final signUp = SignUpModel(
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
      ),
    );
  }
}
