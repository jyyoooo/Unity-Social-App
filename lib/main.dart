import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/auth_feature/bloc/auth_bloc.dart';
import 'package:unitysocial/firebase_options.dart';
import 'features/auth_feature/screens/auth_screen.dart';

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
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unity Social',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 150)),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
