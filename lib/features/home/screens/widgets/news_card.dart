import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/default_image.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';
import 'package:unitysocial/features/news/screens/news_details_page.dart';

class NewsCard extends StatelessWidget {
  final News newsData;

  const NewsCard({required this.newsData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        log('news url ${newsData.url}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsPage(newsData: newsData),
            // fullscreenDialog: true
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CupertinoColors.lightBackgroundGray.withOpacity(.5),
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
                    const SizedBox(height: 3, width: null),
                    _newsDescription(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    return SizedBox(
      height: 85,
      width: 85,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: newsData.urlToImage != null
            ? Hero(transitionOnUserGestures: true,
                tag: newsData.urlToImage!,
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: defaultImage,
                    image: NetworkImage(newsData.urlToImage!),
                    imageErrorBuilder: (context, error, stackTrace) {
                      log('error loading image: $error');
                      return Image.asset('assets/unity-default-image.png',
                          fit: BoxFit.cover);
                    }),
              )
            : Image.asset(
                'assets/unity-default-image.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
      ),
    );
  }

  Widget _newsDescription(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        newsData.description ?? 'No Description',
        style: const TextStyle(
          fontSize: 12,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  Widget _newsTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Hero(
        tag: newsData.title ?? 'news_title',
        child: Text(
          newsData.title ?? 'No title',
          maxLines: 3,
          style: TextStyle(
            color: Colors.grey[850],
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
