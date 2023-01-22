class News {
  String source = "";
  String urlToImage = "";
  String description = "";
  News(
      {required this.source,
      required this.urlToImage,
      required this.description});

  News.fromJson(Map<String, dynamic> json) {
    source = json['articles'];
    urlToImage = json['urlToImage'];
    description = json['description'];
  }
}
