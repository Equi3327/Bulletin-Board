import 'dart:convert';

class News {
  final String source;
  final String urlToImage;
  final String description;
  final String url;
  final String author;
  final String title;
  final String content;

  News({
    required this.source,
    required this.urlToImage,
    required this.description,
    required this.url,
    required this.author,
    required this.title,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    try {
      String source = Source.fromJson(json['source']).name;

      String urlToImage = json['urlToImage'] ?? "NA";
      String description = json['description'] ?? "NA";
      String url = json['url'] ?? "NA";
      String author = json['author'] ?? "NA";
      String title = json['title'] ?? "NA";
      String content = json['content'] ?? "NA";
      return News(
        source: source,
        urlToImage: urlToImage,
        description: description,
        url: url,
        content: content,
        title: title,
        author: author,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class Source {
  final String name;
  Source({required this.name});
  factory Source.fromJson(Map<String, dynamic> json) {
    try {
      String name = json['name'] ?? "NA";
      return Source(
        name: name,
      );
    } catch (e) {
      print('Error in parsing Source');
    }
    return Source(name: "");
  }
}
