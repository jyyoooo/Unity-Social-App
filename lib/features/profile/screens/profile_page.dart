import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';
import 'package:unitysocial/features/auth/screens/auth_page.dart';
import 'package:unitysocial/features/profile/screens/widgets/sign_out_button.dart';
import 'widgets/tile_item_widget.dart';

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
              BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (context, state) => state is LoginSuccesState,
                  builder: (context, state) {
                    if (state is UserFoundState) {
                      return _showProfileStats(state);
                    } else if (state is LoginSuccesState) {
                      return _showProfileStats(state);
                    }
                    return const Center(
                      child: Text('Error fetching user profile'),
                    );
                  }),
              const SizedBox(height: 20),
              TileItem(
                  title: 'Your Projects',
                  onTap: () => Navigator.pushNamed(context, '/yourProjects'),
                  icon: Icon(Icons.folder_shared_rounded,
                      color: CupertinoColors.systemCyan.highContrastColor)),
              const SizedBox(height: 5),
              TileItem(
                  title: 'Your Contributions',
                  onTap: () {
                    Navigator.pushNamed(context, '/yourStats');
                  },
                  icon: const Icon(
                    Icons.bar_chart_rounded,
                    color: CupertinoColors.systemGreen,
                  )),
              const SizedBox(height: 5),
              TileItem(
                  title: 'Accreditations',
                  onTap: () {
                    Navigator.pushNamed(context, '/accreditations');
                  },
                  icon: Icon(CupertinoIcons.text_badge_star,
                      color: CupertinoColors.systemYellow.withRed(1000))),
              const Spacer(),
              // _signOutButton(context),
              const AnimatedSignOutButton(),
              const SizedBox(height: 70)
            ],
          ),
        ),
      ),
    );
  }

  Widget _showProfileStats(state) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        // boxShadow: const [
        //   BoxShadow(
        //       offset: Offset(0, .5),
        //       blurRadius: 1,
        //       color: CupertinoColors.lightBackgroundGray)
        // ],
        color: CupertinoColors.lightBackgroundGray.withOpacity(.6),
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
                      color: Colors.grey,
                    )),
                const SizedBox(width: 10),
                Text(
                  state.userName,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.verified_rounded,
                  size: 20,
                  color: CupertinoColors.activeBlue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // COMPONENTS

  PreferredSize _showProfileAppbar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(title: 'Profile'));
  }

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
