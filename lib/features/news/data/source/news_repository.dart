import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:unitysocial/core/secrets/news_api.dart';
import 'package:unitysocial/features/news/data/model/news_model.dart';

class NewsRepository {

  static Future<List<News>> fetchLatestNews() async {


    try {
      final response = await Dio().get('https://newsapi.org/v2/top-headlines?country=us&apiKey=b8bdd68ab3c64f7eae9214c979285068');
      log('response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.data);
        final List<dynamic> articles = decodedData['articles'];
        return articles.map((item) {
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
        throw Exception('Response Error: ${response.statusCode}');
      }
    // } on SocketException catch (e) {
    //   log('SocketException: $e');
    //   throw Exception('Failed to fetch news due to network issues');
    // } on HttpException catch (e) {
    //   log('HttpException: $e');
    //   throw Exception('Failed to fetch news due to server issues');
    // } on FormatException catch (e) {
    //   log('FormatException: $e');
    //   throw Exception('Failed to parse news data');
    } catch (e) {
      log('Unknown error: $e');
      return [];
      // throw Exception('Failed to fetch news due to an unknown error');
    }
  }
}
