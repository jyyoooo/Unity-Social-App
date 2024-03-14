import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_screen.dart';
import 'package:unitysocial/features/home/navigation_bloc/navigation_bloc.dart';
import 'package:unitysocial/features/recruit/bloc/recruit_bloc.dart';
import 'package:unitysocial/firebase_options.dart';

import 'features/home/screens/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const UnitySocialApp());
}

class UnitySocialApp extends StatelessWidget {
  const UnitySocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => RecruitBloc()),
      ],
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Unity Social',
      //   theme: ThemeData(
      //     textTheme: GoogleFonts.ralewayTextTheme(
      //       Theme.of(context).textTheme,
      //     ),
      //     colorScheme: ColorScheme.fromSeed(
      //         seedColor: const Color.fromARGB(255, 58, 183, 150)),
      //     useMaterial3: true,
      //   ),
      //   home: const AuthPage(),
      // ),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while waiting
          }

          final user = snapshot.data;
          if (user != null) {
            return MaterialApp(
              theme: ThemeData(
                textTheme: GoogleFonts.ralewayTextTheme(
                  Theme.of(context).textTheme,
                ),
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 58, 183, 150)),
                useMaterial3: true,
              ),
              home: const RootPage(),
            );
          } else {
            return MaterialApp(
              theme: ThemeData(
                textTheme: GoogleFonts.ralewayTextTheme(
                  Theme.of(context).textTheme,
                ),
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 58, 183, 150)),
                useMaterial3: true,
              ),
              home: const AuthPage(),
            );
          }
        },
      ),
    );
  }
}
