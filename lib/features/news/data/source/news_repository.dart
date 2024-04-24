import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:unitysocial/core/secrets/news_api.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';

class NewsRepository {
  static final client = http.Client();

  Future<List<News>> fetchLatestNews() async {
    try {
      final response = await client.get(Uri.parse(anotherURL));
      log('response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        log('in if condition');
        final decodedData = json.decode(response.body);
        final List<dynamic> articles = decodedData['articles'];
        log('item from article: ${articles.first['content']}');
        return articles.map((item) {
          item.toString();
          return News(
            title: item['title'],
            description: item['description'],
            urlToImage: item['urlToImage'],
            content: item['content'],
            publishedAt: item['publishedAt'],
            source: item['source'],
            url: item['url']
          );
        }).toList();
      } else {
        throw Exception('Response Error');
      }
    } catch (e) {
      log('Error fetching news: $e');
      throw Exception('Failed to fetch news');
    }
  }
}
