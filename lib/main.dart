import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/widgets/unity_text_field/obscurity_cubit.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/screens/splash_page.dart';
import 'features/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'features/home/bloc/posts_bloc.dart';
import 'features/home/screens/widgets/navigation_bloc.dart';
import 'features/recruit/bloc/recruit_bloc.dart';
import 'features/search/bloc/search_bloc.dart';
import 'features/volunteer/bloc/volunteer_bloc.dart';
import 'features/your_projects/bloc/projects_bloc.dart';
import 'firebase_options.dart';

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
        BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(create: (context) => Obscurity()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => VolunteerBloc()),
        BlocProvider(create: (context) => ProjectsBloc()),
        BlocProvider(create: (context) => NavigationCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unity Social',
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 150)),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
