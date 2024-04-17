import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 950), () {
      context.read<AuthBloc>().add(AppStartEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is NoUserState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ));
          } else if (state is UserFoundState) {
            log(FirebaseAuth.instance.currentUser!.uid);
            showSnackbar(context, 'Logged in as ${state.userName}',
                CupertinoColors.systemMint.highContrastColor);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const UnityNavigator(),
            ));
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/UnitySocial-logo.svg'),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 80,
                      child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(12),
                          color: buttonGreen))
                ],
              ),
            ),
          ),
        ));
  }
}
