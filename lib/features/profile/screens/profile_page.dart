import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/auth/screens/auth_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  PreferredSize(
            preferredSize:const Size.fromHeight(100),
            child: UnityAppBar(
              title: 'Profile',
            )),
        body: Center(
            child: Column(
          children: [
            ListTile(
              leading:
                  const Icon(CupertinoIcons.rectangle_stack_badge_person_crop),
              title: const Text('Your Projects'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            const Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => const AuthPage())));
                  } on FirebaseAuthException catch (error) {
                    log(error.toString());
                  }
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: CupertinoColors.systemRed),
                ))
          ],
        )));
  }
}
