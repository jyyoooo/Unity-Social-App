import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishYellowCard extends StatelessWidget {
  const WishYellowCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                  color: Colors.grey[200]!)
            ],
            gradient: const RadialGradient(colors: [
              Color(0XFFFFf2cd),
              Color(0XFFFFEaa7),
              Color(0XFFFFEd7F),
              Color(0xFFFFF57F),
            ]),
            borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Happy Volunteering!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Thanks for being a part of the unity community'),
              const SizedBox(height: 40),
              SvgPicture.asset('assets/heart_in_hand.svg'),
            ],
          ),
        ),
      ),
    );
  }
}