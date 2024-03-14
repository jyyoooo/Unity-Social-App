import 'package:flutter/material.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bar.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      bottomNavigationBar: UnityNavigator(),
    );
  }
}
