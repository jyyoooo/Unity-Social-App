import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_screen.dart';
import 'package:unitysocial/features/home/screens/root_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AppStartEvent());
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is NoUserState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ));
        } else if (state is UserFoundState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const RootPage(),
          ));
        }
      },
     child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)), // Delay for 2 seconds
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              // Your splash screen UI
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
