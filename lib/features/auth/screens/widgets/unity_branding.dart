import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';

class BrandingSection extends StatelessWidget {
  const BrandingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 9,
          ),
          SvgPicture.asset('assets/UnitySocial-logo.svg'),
          Text(
            'Unity',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const Text(
            'Social volunteering app',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
