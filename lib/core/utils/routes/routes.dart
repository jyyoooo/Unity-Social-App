import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unitysocial/features/community/screens/community_page.dart';
import 'package:unitysocial/features/home/screens/home_page.dart';
import 'package:unitysocial/features/profile/screens/profile_page.dart';
import 'package:unitysocial/features/your_projects/screens/your_projects.dart';
import 'package:unitysocial/features/recruit/screens/recruit_form.dart';
import 'package:unitysocial/features/recruit/screens/recruit_page.dart';

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
      iconSize: 25,
      inactiveIcon: const Icon(CupertinoIcons.house),
      icon: const Icon(CupertinoIcons.house_fill),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      iconSize: 33,
      inactiveIcon: const Icon(CupertinoIcons.group),
      icon: const Icon(CupertinoIcons.group_solid),
      title: ("Community"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      iconSize: 25,
      routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
        '/recruitForm': (context) => const RecruitForm(),
      }),
      inactiveIcon: const Icon(CupertinoIcons.person_add),
      icon: const Icon(CupertinoIcons.person_add_solid),
      title: ("Recruit"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
          routes: {'/yourProjects': (context) => const YourProjects()}),
      iconSize: 25,
      inactiveIcon: const Icon(CupertinoIcons.person_crop_circle),
      icon: const Icon(CupertinoIcons.person_crop_circle_fill),
      title: ("Profile"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
