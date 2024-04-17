import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unitysocial/features/notifications/screens/notification_page.dart';
import 'package:unitysocial/features/search/screens/search_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceMaterialTransparency: true,
      excludeHeaderSemantics: true,
      snap: false,
      stretch: true,
      foregroundColor: Colors.transparent,
      floating: true,
      toolbarHeight: 80,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(.7),
              child: ClipPath(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                _title(),
                const Spacer(),
                Row(
                  children: [_search(context), _notifications(context)],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // REFACTORED WIDGETS

  IconButton _notifications(context) {
    return IconButton(
        iconSize: 20,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotificationPage(),
          ));
        },
        icon:
            const Icon(CupertinoIcons.bell, color: CupertinoColors.systemBlue));
  }

  IconButton _search(BuildContext context) {
    return IconButton(
        iconSize: 20,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        icon: const Icon(CupertinoIcons.search,
            color: CupertinoColors.systemBlue));
  }

  IconButton _location() {
    return IconButton(
        iconSize: 20,
        onPressed: () {},
        icon: const Icon(CupertinoIcons.location,
            color: CupertinoColors.systemBlue));
  }

  Widget _title() => Row(
        children: [
          SvgPicture.asset('assets/UnitySocial-logo.svg', width: 50),
          const SizedBox(width: 8),
          const Text(
            'Unity Social',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              // color: buttonGreen,
            ),
          )
        ],
      );
}
