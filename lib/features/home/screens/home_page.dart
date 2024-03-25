import 'package:flutter/material.dart';
import 'package:unitysocial/features/home/screens/widgets/category_distribution_widget.dart';
import 'widgets/cause_category_card.dart';
import 'widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
