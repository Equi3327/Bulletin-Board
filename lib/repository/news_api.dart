import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/news/model/news_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=e08acc0545e3438babdc1451be6f36c4';

  Future<News> fetchNewsList() async {
    try {
      Response response = await _dio.get(_url);
      Map<String, dynamic> json = jsonDecode(response.data);
      // int totalResults = response.data['totalResults'];
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++");
      List<dynamic> articles = json['articles'];
      final List<News> newsList = [];
      articles.forEach((element) {});
      print(articles);

      return News(
        description: "abhsdajgd",
        source: "shfkshfs",
        urlToImage: "hifshidfhishdf",
      );
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return News(description: "", source: "", urlToImage: "");
    }
  }
}

class ApiRepository {
  final _provider = ApiProvider();

  Future<News> fetchNewsList() {
    return _provider.fetchNewsList();
  }
}

class NetworkError extends Error {}
