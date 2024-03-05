import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class RecruitPage extends StatelessWidget {
  const RecruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: UnityAppBar(
            title: 'Recruit',
          )),
      body: Center(
        child: Text('Recruit'),
      ),
    );
  }
}
