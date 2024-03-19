import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/search/screens/search_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarKey = GlobalKey();

    return SliverAppBar(
      forceMaterialTransparency: true,
      floating: true,
      toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: Row(
          children: [
            const Text(
              'Pick a Cause',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.location)),
                IconButton(
                    iconSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.search)),
                IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.bell))
              ],
            )
          ],
        ),
      ),
    );
  }
}
