
import '../bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/signup_form.dart';
import 'widgets/tab_properties.dart';
import 'widgets/unity_branding.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthBloc>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BrandingSection(),
            const TabProperties(),
            Expanded(
                child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                  SignUpForm(blocProvider: blocProvider),
                  LoginForm(blocProvider: blocProvider)
                ])),
          ],
        ),
      ),
    );
  }
}
