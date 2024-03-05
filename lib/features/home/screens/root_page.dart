import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/constants/constants.dart';
import 'package:unitysocial/features/home/navigation_bloc/navigation_bloc.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bar.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return IndexedStack(index: state.index, children: screens);
        },
      ),
      bottomNavigationBar: const UnityNavigationBar(),
    );
  }
}
