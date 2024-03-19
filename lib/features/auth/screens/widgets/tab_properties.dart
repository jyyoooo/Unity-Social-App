import 'package:flutter/material.dart';

class TabProperties extends StatelessWidget {
  const TabProperties({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.of(context).size.width / 1.7,
      height: MediaQuery.of(context).size.height / 22,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TabBar(
          indicatorColor: Colors.grey.withOpacity(.3),
          dividerColor: Colors.transparent,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          unselectedLabelColor: Colors.black54,
          labelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Sign Up'),
            Tab(text: 'Log In'),
          ],
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          labelColor: Colors.black,
        ),
      ),
    );
  }
}
