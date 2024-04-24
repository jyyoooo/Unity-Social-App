// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unitysocial/core/constants/default_image.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/core/formatters/date_formatter.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({Key? key, required this.newsData}) : super(key: key);
  final News newsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: UnityAppBar(
            title: newsData.source['name'] as String,
            smallTitle: true,
            // enableCloseAction: true,
            showBackBtn: true,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsData.title ?? 'No title',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newsData.publishedAt != null
                        ? formatPublishedDate(newsData.publishedAt!)
                        : 'Date unavailable',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  newsData.url == 'https://removed.com'
                      ? const IconButton(
                          color: CupertinoColors.systemGrey,
                          onPressed: null,
                          icon: Icon(CupertinoIcons.share),
                        )
                      : IconButton(
                          color: CupertinoColors.activeBlue,
                          onPressed: () => Share.share(
                              newsData.url.isEmpty ? '' : newsData.url,
                              subject: newsData.title),
                          icon: const Icon(CupertinoIcons.share),
                        ),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: newsData.urlToImage != null
                            ? Hero(
                                tag: newsData.urlToImage ?? newsData,
                                child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: defaultAssetImage,
                                    image: NetworkImage(newsData.urlToImage!),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      log('error loading image: $error');
                                      return Image.asset(
                                          'assets/unity-default-image.png',
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high);
                                    }),
                              )
                            : Image.asset('assets/unity-default-image.png',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high),
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              Text(newsData.description ?? 'News description unavailable',
                  style: const TextStyle(fontSize: 15)),
              Text(newsData.content ?? 'Content unavailable',
                  style: const TextStyle(fontSize: 15))
            ],
          ),
        ),
      ),
    );
  }
}
