import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/cause_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                height: 90,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      CauseCard(
                          color: const Color.fromARGB(255, 255, 214, 98),
                          sizer: size,
                          image: 'assets/paw.png',
                          title: 'Animals'),
                      CauseCard(
                          color: const Color.fromARGB(255, 255, 176, 57),
                          sizer: size,
                          image: 'assets/humans.png',
                          title: 'Humanity'),
                      CauseCard(
                          color: const Color.fromARGB(255, 109, 196, 255),
                          sizer: size,
                          image: 'assets/water.png',
                          title: 'Water'),
                      CauseCard(
                        scale: 2.4,
                          color: const Color.fromRGBO(37, 204, 140, .77),
                          sizer: size,
                          image: 'assets/globe.png',
                          title: 'Environment'),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
