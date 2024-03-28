import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/search/screens/search_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(forceMaterialTransparency: true,
      excludeHeaderSemantics: true,
      // forceElevated: true,
      snap: true,
      stretch: true,
      foregroundColor: Colors.transparent,
      // shadowColor: Colors.grey.withOpacity(.1),
      // backgroundColor: Colors.grey.withOpacity(.0001),
      floating: true,
      toolbarHeight: 80,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(.1),
              child: ClipPath(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
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
                  children: [_location(), _search(context), _notifications()],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _notifications() {
    return IconButton(
        iconSize: 20, onPressed: () {}, icon: const Icon(CupertinoIcons.bell));
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
        icon: const Icon(CupertinoIcons.search));
  }

  IconButton _location() {
    return IconButton(
        iconSize: 20,
        onPressed: () {},
        icon: const Icon(CupertinoIcons.location));
  }

  Text _title() {
    return const Text(
      'Pick a Cause',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
