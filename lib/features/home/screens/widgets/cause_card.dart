// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CauseCard extends StatelessWidget {
  const CauseCard({
    Key? key,
    required this.sizer,
    required this.image,
    required this.title,
    required this.color,
    this.scale = 2.3, required this.onTap,
  }) : super(key: key);

  final Size sizer;
  final String image;
  final String title;
  final Color color;
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizer.height / 4.2,
      width: sizer.width / 4.2,
      child: Card(
        color: color,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, scale: scale),
                Text(title, style: const TextStyle(fontSize: 12))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
