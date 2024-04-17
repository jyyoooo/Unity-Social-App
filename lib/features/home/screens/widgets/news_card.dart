import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/default_image.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;

  const NewsCard(
      {required this.title,
      required this.description,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(seconds: 1),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CupertinoColors.lightBackgroundGray.withOpacity(.7),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 3,
      ),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _showImage(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _newsTitle(),
                  const SizedBox(height: 3),
                  _newsDescription()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _showImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
          height: 85,
          width: 85,
          child: imageUrl != null
              ? FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: defaultImage,
                  image: NetworkImage(imageUrl!),
                  imageErrorBuilder: (context, error, stackTrace) {
                    log('error loading image: $error');
                    return Image.asset('assets/unity-default-image.png',
                        fit: BoxFit.cover);
                  },
                )
              : Image.asset(
                  'assets/unity-default-image.png',
                  fit: BoxFit.cover,
                )),
    );
  }

  Padding _newsDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Expanded(
        child: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          description,
          style: const TextStyle(
            fontSize: 12,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ),
    );
  }

  Widget _newsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        maxLines: 3,
        style:  TextStyle(color: Colors.grey[850],
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
