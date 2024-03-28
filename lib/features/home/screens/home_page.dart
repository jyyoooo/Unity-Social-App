import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:unitysocial/features/home/screens/widgets/category_distribution_widget.dart';
import 'widgets/cause_category_card.dart';
import 'widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width / 2,
                  height: size.height / 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _showCategoryRow(context, size),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipPath(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        'News',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0, 2.5),
                            color: CupertinoColors.systemGrey5,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: .5)
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: CupertinoColors.white,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 3,
                    ),
                    height: 140,
                    child: const Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: SizedBox(
                            height: 125,
                            width: 125,
                            child: Placeholder(
                              strokeWidth: .5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Text(
                                  'Title goes here',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                child: Text(
                                  'Description lorem ipsum sit dolor amet asd fsadgadfhsdgh sgg',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _showCategoryRow(BuildContext context, Size size) {
    return [
      CauseCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CauseCategoryPage(
                    categoryName: 'Animals', query: 'Animals'),
              ),
            );
          },
          color: const Color.fromARGB(255, 255, 214, 98),
          sizer: size,
          image: 'assets/paw.png',
          title: 'Animals'),
      CauseCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CauseCategoryPage(
                      categoryName: 'Humanitarian', query: 'Humanitarian'),
                ));
          },
          color: const Color.fromARGB(255, 255, 176, 57),
          sizer: size,
          image: 'assets/humans.png',
          title: 'Humanity'),
      CauseCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CauseCategoryPage(categoryName: 'Water', query: 'Water'),
                ));
          },
          color: const Color.fromARGB(255, 109, 196, 255),
          sizer: size,
          image: 'assets/water.png',
          title: 'Water'),
      CauseCard(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CauseCategoryPage(
                      categoryName: 'Environment', query: 'Environment'),
                ));
          },
          scale: 2.4,
          color: const Color.fromRGBO(37, 204, 140, .77),
          sizer: size,
          image: 'assets/globe.png',
          title: 'Environment'),
    ];
  }
}
