import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';

class YourProjects extends StatelessWidget {
  const YourProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: PreferredSize(preferredSize: Size.fromHeight(100), child: UnityAppBar(title: 'Your Projects')),);
  }
}