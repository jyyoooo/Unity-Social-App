import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: UnityAppBar(
              title: 'Profile',
            )),
        body: Center(
            child: Column(
          children: [
            const Text('Your Profile'),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                  } on FirebaseAuthException catch (error) {
                    log(error.toString());
                  }
                },
                child: const Text('Sign Out'))
          ],
        )));
  }
}
