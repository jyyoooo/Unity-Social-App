import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/home/navigation_bloc/navigation_bloc.dart';

class UnityNavigationBar extends StatelessWidget {
  const UnityNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return ClipPath(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 11,
              child: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (index) {
                    context
                        .read<NavigationBloc>()
                        .add(ChangeScreenEvent(index: index));
                  },
                  enableFeedback: true,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: const Color.fromRGBO(57, 129, 248, 1),
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home),
                        label: 'Home',
                        backgroundColor: Colors.transparent),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.globe),
                        label: 'Community',
                        backgroundColor: Colors.transparent),
                    BottomNavigationBarItem(
                        activeIcon: Icon(CupertinoIcons.person_3_fill),
                        icon: Icon(CupertinoIcons.person_3),
                        label: 'Recruit',
                        backgroundColor: Colors.transparent),
                    BottomNavigationBarItem(
                        activeIcon:
                            Icon(CupertinoIcons.person_crop_circle_fill),
                        icon: Icon(CupertinoIcons.person_crop_circle),
                        label: 'Profile',
                        backgroundColor: Colors.transparent),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
