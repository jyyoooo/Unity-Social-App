import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  final String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showProfileAppbar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) =>
                      state is LoginSuccesState || state is UserFoundState,
                  builder: (context, state) {
                    if (state is UserFoundState) {
                      return SizedBox(
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.lightBackgroundGray
                                .withOpacity(.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 30,
                                        child: Icon(
                                          CupertinoIcons.person_crop_circle,
                                          size: 35,
                                        )),
                                    const SizedBox(width: 10),
                                    Text(
                                      state.userName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: Text('Error fetching user profile'),
                    );
                  }),
              const SizedBox(height: 20),
              ListTile(
                tileColor: CupertinoColors.lightBackgroundGray.withOpacity(.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                leading: const Icon(
                    CupertinoIcons.rectangle_stack_badge_person_crop),
                title: const Text('Your Projects'),
                onTap: () {
                  Navigator.pushNamed(context, '/yourProjects');
                },
              ),
              const Spacer(),
              _signOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _showProfileAppbar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(title: 'Profile'));
  }

  // COMPONENTS

  _signOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        titleTextStyle: const TextStyle(color: CupertinoColors.systemRed),
        title: const Text('Sign out'),
        iconColor: CupertinoColors.systemRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: CupertinoColors.lightBackgroundGray.withOpacity(.6),
        leading: const Icon(CupertinoIcons.square_arrow_right),
        onLongPress: () async {
          try {
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            });
          } on FirebaseAuthException catch (error) {
            log(error.toString());
          }
        },
      ),
    );
  }
}
