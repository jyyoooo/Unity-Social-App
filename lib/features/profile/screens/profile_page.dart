import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: UnityAppBar(
              title: 'Profile',
            )),
        body:  Center(child: Text('Your Profile')));
  }
}
