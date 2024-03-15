import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 30.0),
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
                    onPressed: () {},
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
