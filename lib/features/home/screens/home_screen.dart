import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            titleSpacing: 30,
            floating: true,
            toolbarHeight: 100,
            title: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: [
                  const Text(
                    'Pick a Cause',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.location)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.search)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.bell))
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const Card(
                  child: ListTile(
                    title: Text('Newssssssssss'),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
