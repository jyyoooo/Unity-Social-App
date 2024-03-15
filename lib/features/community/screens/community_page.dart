import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: UnityAppBar(
              title: 'Community',
            )),
        body: Center(
          child: Text('Unity Community'),
        ));
  }
}
