import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/features/community/bloc/chat_bloc.dart';
import 'package:unitysocial/features/community/cubit/segment_cubit.dart';
import 'package:unitysocial/features/push_notification/push_notification_service.dart';
import 'package:unitysocial/features/recruit/bloc/cubit/slider_cubit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'core/constants/unity_text_field/obscurity_cubit.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/screens/splash_page.dart';
import 'features/donation/bloc/donation_button_cubit.dart';
import 'features/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'features/home/bloc/posts_bloc.dart';
import 'features/home/screens/widgets/navigation_bloc.dart';
import 'features/profile/screens/widgets/sign_out_cubit/cubit.dart';
import 'features/recruit/bloc/recruit_bloc.dart';
import 'features/search/bloc/search_bloc.dart';
import 'features/volunteer/bloc/volunteer_bloc.dart';
import 'features/your_projects/bloc/projects_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationService.init();
  await PushNotificationService.initLocalNotifications();
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((message) {
    PushNotificationService.display(message);
  });



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
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => ButtonCubit()),
        BlocProvider(create: (context) => SignOutCubit()),
        BlocProvider(create: (context) => SegmentCubit(0)),
        BlocProvider(create: (context) => SliderCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unity Social',
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 150)),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
