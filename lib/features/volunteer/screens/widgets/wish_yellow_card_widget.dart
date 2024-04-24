import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishYellowCard extends StatelessWidget {
  const WishYellowCard({
    super.key,
    this.showVolunteer = true,
  });
  final bool showVolunteer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            // boxShadow: const [
            //   BoxShadow(
            //       spreadRadius: 8,
            //       blurRadius: 18,
            //       offset: const Offset(0, 2),
            //       color: CupertinoColors.extraLightBackgroundGray)
            // ],
            gradient: RadialGradient(colors: [
              CupertinoColors.systemYellow.withOpacity(.2208),
              CupertinoColors.systemYellow.withOpacity(.3208),
              CupertinoColors.systemYellow.withOpacity(.4208),
              CupertinoColors.systemYellow.withOpacity(.5208),
              CupertinoColors.systemYellow.withOpacity(.6208),
            ]),
            borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              showVolunteer
                  ? const Text('Happy Volunteering!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  : const SizedBox(),
              const SizedBox(height: 10),
              const Text(
                'Your kindness makes a positive impact in the world.',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 40),
              SvgPicture.asset('assets/heart_in_hand.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
