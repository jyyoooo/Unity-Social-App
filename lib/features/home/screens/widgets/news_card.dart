import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/default_image.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';
import 'package:unitysocial/features/news/screens/news_details_page.dart';

class NewsCard extends StatelessWidget {
  final News newsData;

  NewsCard({required this.newsData, Key? key}) : super(key: key);
  bool isErrorImage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CupertinoColors.extraLightBackgroundGray,
                CupertinoColors.lightBackgroundGray
              ])),
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 3,
      ),
      height: 100,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          log(newsData.urlToImage.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailsPage(newsData: newsData)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _showImage(isErrorImage),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_newsTitle()],
                    ),
                  ),
                ],
              ),
              _showReadMore(),
            ],
          ),
        ),
      ),
    );
  }

  // refactored widgets

  Widget _showReadMore() {
    return const Positioned(
      bottom: 3.5,
      right: 3,
      child: Text(
        softWrap: true,
        'Read more',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _showImage(bool isErrorImage) {
    final tag = newsData.urlToImage ?? defaultAssetImage;

    return SizedBox(
      height: 85,
      width: 85,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Builder(
          builder: (context) {
            try {
              return newsData.urlToImage != null
                  ? Hero(
                      tag: tag,
                      flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                      ) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: isErrorImage
                                    ? Image.asset(
                                        defaultImagePath,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(newsData.urlToImage!,
                                        fit: BoxFit.cover));
                          },
                        );
                      },
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: defaultAssetImage,
                        image: NetworkImage(newsData.urlToImage!),
                        imageErrorBuilder: (context, error, stackTrace) {
                          log('Error loading image: $error');
                          isErrorImage = true;
                          return Image.asset(
                            'assets/unity-default-image.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : Image.asset(
                      'assets/unity-default-image.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    );
            } catch (e) {
              log('Error in _showImage: $e');
              return Image.asset(
                'assets/unity-default-image.png',
                fit: BoxFit.cover,
              );
            }
          },
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
    return Flexible(
      child: Text(
        newsData.title ?? 'No title',
        style: TextStyle(
          color: Colors.grey[850],
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }
}
