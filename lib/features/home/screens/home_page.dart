import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/home/screens/widgets/category_distribution_widget.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';
import 'package:unitysocial/features/news/data/source/news_repository.dart';
import 'widgets/cause_category_card.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/news_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          const HomeAppBar(),
          _pickACauseTitle(),
          _showCategorySliver(size, context),
          _newsTitle(),
          // _showNewsList(),
          const SliverToBoxAdapter(child: SizedBox(height: 75))
        ],
      ),
    );
  }

  // refactored widgets

  FutureBuilder<List<News>> _showNewsList() {
  return FutureBuilder<List<News>>(
    future: NewsRepository.fetchLatestNews(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SliverToBoxAdapter(
          child: SizedBox(height: 400, child: CupertinoActivityIndicator()),
        );
      } else if (snapshot.hasError) {
        log('snapshot error: ${snapshot.error}');
        return const SliverToBoxAdapter(
          child: Center(
            child: Text(
              'Something went wrong. Please check your internet connection and try again.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      } else if (snapshot.hasData) {
        if (snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No news available at the moment.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return NewsCard(
                newsData: snapshot.data![index],
              );
            },
            childCount: snapshot.data!.length,
          ),
        );
      }
      return const SliverToBoxAdapter(
        child: Center(
          child: Text(
            'No data available.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    },
  );
}



  SliverToBoxAdapter _newsTitle() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        width: 50,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text('Latest News',
              style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  SliverToBoxAdapter _pickACauseTitle() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
        child: Text('Pick a Cause',
            style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  SliverToBoxAdapter _showCategorySliver(Size size, BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: 85,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                            categoryName: 'Humanitarian',
                            query: 'Humanitarian'),
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
                        builder: (context) => CauseCategoryPage(
                            categoryName: 'Water', query: 'Water'),
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
          ],
        ),
      ),
    );
  }
}
