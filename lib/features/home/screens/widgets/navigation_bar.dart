import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unitysocial/core/utils/routes/routes.dart';
import 'navigation_bloc.dart';

class UnityNavigator extends StatelessWidget {
  const UnityNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);

    return BlocBuilder<NavigationCubit, NavigationVisibility>(
      builder: (context, state) {
        bool hideNavBar = false;
        if (state == NavigationVisibility.hideNavBar) {
          log('emitted hideNavbar');
          hideNavBar = true;
        } else if (state == NavigationVisibility.showNavBar) {
          log('emitted showNavbar');
          hideNavBar = false;
        }
        return Material(
          color: CupertinoColors.systemGrey6.withOpacity(.6),
          child: SafeArea(
            child: ClipPath(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: PersistentTabView(
                  context,
                  hideNavigationBar: false,
                  navBarHeight: hideNavBar ? 0 : 70,
                  controller: controller,
                  screens: buildScreens(),
                  items: navBarItems(),
                  confineInSafeArea: true,
                  handleAndroidBackButtonPress: true,
                  resizeToAvoidBottomInset: false,
                  stateManagement: false,
                  hideNavigationBarWhenKeyboardShows: true,
                  popAllScreensOnTapOfSelectedTab: true,
                  navBarStyle: NavBarStyle.simple,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
