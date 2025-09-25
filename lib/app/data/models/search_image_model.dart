


class SearchImage {
  final int position;
  final String thumbnail;
  final String imageUrl;
  final String? sourceUrl;
  final String title;
  final String link;
  final String source;

  SearchImage({
    required this.position,
    required this.thumbnail,
    required this.imageUrl,
    this.sourceUrl,
    required this.title,
    required this.link,
    required this.source,
  });

  factory SearchImage.fromJson(Map<String, dynamic> json) {
    return SearchImage(
      position: json['position'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      sourceUrl: json['sourceUrl'],
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      source: json['source'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'thumbnail': thumbnail,
      'sourceUrl': sourceUrl,
      'title': title,
      'link': link,
      'source': source,
    };
  }
}
