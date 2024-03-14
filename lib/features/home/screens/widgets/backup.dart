// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:unitysocial/features/home/navigation_bloc/navigation_bloc.dart';

// class UnityNavigationBar extends StatelessWidget {
//   const UnityNavigationBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavigationBloc, NavigationState>(
//       builder: (context, state) {
//         return ClipPath(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height / 11,
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(.05),
//                       blurRadius: 2,
//                       spreadRadius: 1,
//                       offset: const Offset(0.0, 1),
//                     )
//                   ],
//                 ),
//                 child: BottomNavigationBar(
//                     currentIndex: state.index,
//                     onTap: (index) {
//                       context
//                           .read<NavigationBloc>()
//                           .add(ChangeScreenEvent(index: index));
//                     },
//                     enableFeedback: true,
//                     type: BottomNavigationBarType.fixed,
//                     backgroundColor: Colors.transparent,
//                     elevation: 0,
//                     selectedItemColor: const Color.fromRGBO(57, 129, 248, 1),
//                     selectedFontSize: 12,
//                     unselectedFontSize: 12,
//                     items: const [
//                       BottomNavigationBarItem(
//                           activeIcon: Icon(CupertinoIcons.house_fill),
//                           icon: Icon(CupertinoIcons.home),
//                           label: 'Home',
//                           backgroundColor: Colors.transparent),
//                       BottomNavigationBarItem(
//                           activeIcon: Icon(
//                             CupertinoIcons.group_solid,
//                             size: 30,
//                           ),
//                           icon: Icon(
//                             CupertinoIcons.group,
//                             size: 30,
//                           ),
//                           label: 'Community',
//                           backgroundColor: Colors.transparent),
//                       BottomNavigationBarItem(
//                           activeIcon: Icon(CupertinoIcons.person_add_solid),
//                           icon: Icon(CupertinoIcons.person_add),
//                           label: 'Recruit',
//                           backgroundColor: Colors.transparent),
//                       BottomNavigationBarItem(
//                           activeIcon:
//                               Icon(CupertinoIcons.person_crop_circle_fill),
//                           icon: Icon(CupertinoIcons.person_crop_circle),
//                           label: 'Profile',
//                           backgroundColor: Colors.transparent),
//                     ]),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:unitysocial/features/home/screens/home_page.dart';
// import 'package:unitysocial/features/profile/screens/profile_page.dart';
// import 'package:unitysocial/features/recruit/screens/recruit_form.dart';
// import 'package:unitysocial/features/recruit/screens/recruit_page.dart';
// import 'package:unitysocial/features/community/screens/community_page.dart';

// class UnityNavigator extends StatelessWidget {
//   const UnityNavigator({super.key});
//   @override
//   Widget build(BuildContext context) {
//     PersistentTabController _controller;

//     _controller = PersistentTabController(initialIndex: 0);
//     List<Widget> buildScreens() {
//       return const [HomePage(), CommunityPage(), RecruitPage(), ProfilePage()];
//     }

//     List<PersistentBottomNavBarItem> navBarsItems() {
//       return [
//         PersistentBottomNavBarItem(
//           icon: const Icon(CupertinoIcons.house_fill),
//           title: ("Home"),
//           activeColorPrimary: CupertinoColors.activeBlue,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(CupertinoIcons.group_solid),
//           title: ("Home"),
//           activeColorPrimary: CupertinoColors.activeBlue,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(CupertinoIcons.person_add_solid),
//           title: ("Home"),
//           activeColorPrimary: CupertinoColors.activeBlue,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           routeAndNavigatorSettings: RouteAndNavigatorSettings(routes: {
//             '/recruitForm': (context) => const RecruitForm(),
//             '/testX': (context) => const TestX()
//           }),
//           icon: const Icon(CupertinoIcons.person_crop_circle_fill),
//           title: ("Settings"),
//           activeColorPrimary: CupertinoColors.activeBlue,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//       ];
//     }

//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: buildScreens(),
//       items: navBarsItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white, // Default is Colors.white.
//       handleAndroidBackButtonPress: true, // Default is true.
//       resizeToAvoidBottomInset:
//           true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//       stateManagement: true, // Default is true.
//       hideNavigationBarWhenKeyboardShows:
//           true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: ItemAnimationProperties(
//         // Navigation Bar's items animation properties.
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: ScreenTransitionAnimation(
//         // Screen transition animation on change of selected tab.
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle:
//           NavBarStyle.style1, // Choose the nav bar style with this property.
//     );
//   }
// }
