import 'dart:convert';

class News {
  final String source;
  final String urlToImage;
  final String description;
  final String url;
  News(
      {required this.source,
      required this.urlToImage,
      required this.description,
      required this.url});

  factory News.fromJson(Map<String, dynamic> json) {
    try {
      String source = Source.fromJson(json['source']).name;

      String urlToImage = json['urlToImage'] ?? "";
      String description = json['description'] ?? "";
      String url = json['url'] ?? "";
      return News(
          source: source,
          urlToImage: urlToImage,
          description: description,
          url: url);
    } catch (e) {
      print("Error in parsing News");
    }
    return News(
      source: "",
      urlToImage: "",
      description: "",
      url: "",
    );
  }
}

class Source {
  final String name;
  Source({required this.name});
  factory Source.fromJson(Map<String, dynamic> json) {
    try {
      String name = json['name'] ?? "Anon";
      return Source(
        name: name,
      );
    } catch (e) {
      print('Error in parsing Source');
    }
    return Source(name: "");
  }
}
