
import 'dart:developer';

import 'package:http/http.dart' as http;

class NewsRepository{

  static final httpClient  =  http.Client();

  String newsBaseUrl = 'https://newsapi.org/v2/top-headlines/sources?apiKey=f62ab5e02741407bbdb7391e54ee2421';

  getNews()async{
    var response = await httpClient.get(Uri.parse(newsBaseUrl));
    log(response.statusCode.toString());
  }
}