import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unitysocial/features/community/screens/community_page.dart';
import 'package:unitysocial/features/home/screens/home_page.dart';
import 'package:unitysocial/features/profile/screens/profile_page.dart';
import 'package:unitysocial/features/your_accreditations/screens/accreditations_page.dart';
import 'package:unitysocial/features/your_projects/screens/your_projects.dart';
import 'package:unitysocial/features/recruit/screens/recruit_form.dart';
import 'package:unitysocial/features/recruit/screens/recruit_page.dart';
import 'package:unitysocial/features/your_stats/screens/your_stats_page.dart';

List<Widget> buildScreens() {
  return [
    const HomePage(),
    const CommunityPage(),
    const RecruitPage(),
    const ProfilePage()
  ];
}

List<PersistentBottomNavBarItem> navBarItems() {
  return [
    PersistentBottomNavBarItem(
      opacity: .3,
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      iconSize: 23.5,
      inactiveIcon: const Icon(CupertinoIcons.house),
      icon: const Icon(CupertinoIcons.house_fill),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      iconSize: 34,
      inactiveIcon: const Icon(CupertinoIcons.person_3),
      icon: const Icon(CupertinoIcons.person_3_fill),
      title: ("Community"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        iconSize: 23.5,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
          '/recruitForm': (context) => const RecruitForm(),
        }),
        inactiveIcon: const Icon(CupertinoIcons.add_circled),
        icon: const Icon(CupertinoIcons.add_circled_solid),
        title: ("Recruit"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey),
    PersistentBottomNavBarItem(
      opacity: 0,
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
        '/yourProjects': (context) => const YourProjects(),
        '/yourStats': (context) => YourStats(),
        '/accreditations': (context) => AccreditationsPage()
      }),
      iconSize: 23.5,
      inactiveIcon: const Icon(CupertinoIcons.person_crop_circle),
      icon: const Icon(CupertinoIcons.person_crop_circle_fill),
      title: ("Profile"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
