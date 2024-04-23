// ignore_for_file: public_member_api_docs, sort_constructors_first
class News {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? publishedAt;
  final Map<String, dynamic> source;
  final String url;

  News({
    required this.title,
    required this.description,
    this.urlToImage,
    this.content,
    this.publishedAt,
    this.source = const {},
    this.url = '',
  });
}
