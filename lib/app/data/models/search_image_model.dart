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

class TinEyeImageModel {
  final num score;
  final String imageUrl;
  final String source;
  final String overlay;
  final String domain;

  TinEyeImageModel({
    required this.score,
    required this.imageUrl,
    required this.source,
    required this.overlay,
    required this.domain,
  });

  factory TinEyeImageModel.fromJson(Map<String, dynamic> json) {
    return TinEyeImageModel(
      score: num.tryParse(json['score'].toString()) ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      source: json['source'] ?? '',
      overlay: json['overlay'] ?? '',
      domain: json['domain'] ?? '',
    );
  }
}