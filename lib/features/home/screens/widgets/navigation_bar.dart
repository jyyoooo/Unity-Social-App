import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unitysocial/core/utils/routes/routes.dart';

class UnityNavigator extends StatelessWidget {
  const UnityNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);

    return ClipPath(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: PersistentTabView(
          navBarHeight: 70,
          context,
          controller: controller,
          screens: buildScreens(),
          items: navBarItems(),
          confineInSafeArea: true,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: false,
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.simple,
        ),
      ),
    );
  }
}
