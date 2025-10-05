class SearchImage {
  String? thumbnail;
  String? imageUrl;
  String? sourceUrl;
  String? title;
  String? link;
  String? source;

  SearchImage({
    this.thumbnail,
    this.imageUrl,
    this.sourceUrl,
    this.title,
    this.link,
    this.source,
  });

  factory SearchImage.fromJson(Map<String, dynamic> json) {
    return SearchImage(
      thumbnail: json['thumbnail'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      sourceUrl: json['sourceUrl'],
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      source: json['source'] ?? '',
    );
  }
}
