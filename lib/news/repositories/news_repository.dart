// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/news/model/news_model.dart';

class NewsRepository {
  final Dio _dio = Dio();
  final String _url =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=e08acc0545e3438babdc1451be6f36c4';

  Future<List<News>> fetchNewsList() async {
    try {
      final Response response = await _dio.get(_url);
      if (response.statusCode == 200) {
        var articles = response.data['articles'];
        List<News> newsList = [];
        newsList = articles.map<News>((e) => News.fromJson(e)).toList();
        return newsList;
      } else {
        throw "Error in fetching News";
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw stacktrace;
    }
  }
}
