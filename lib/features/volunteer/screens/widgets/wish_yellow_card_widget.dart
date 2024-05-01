// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishYellowCard extends StatelessWidget {
  const WishYellowCard({
    Key? key,
    this.showVolunteer = true,
    this.cardTitle,
    this.message,
    this.icon,
  }) : super(key: key);
  final bool showVolunteer;
  final String? cardTitle;
  final String? message;
  final Icon? icon;

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
              const SizedBox(height: 10),
              showVolunteer
                  ?  Text(cardTitle?? 'Happy Volunteering!',
                      style:
                         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  : const SizedBox(),
              const SizedBox(height: 10),
               Text(message??
                'Your kindness makes a positive impact in the world.',
                style:const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 40),
              icon??
              SvgPicture.asset('assets/heart_in_hand.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
