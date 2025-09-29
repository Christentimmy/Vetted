import 'dart:ui';

import 'package:get/get.dart';

class PostModel {
  String? id;
  Content? content;
  List<Media>? media;
  Poll? poll;
  String? postType;
  Author? author;
  String? personName;
  String? personAge;
  String? personLocation;
  Stats? stats;
  bool? isFollowing;
  DateTime? createdAt;
  final RxString? reactedEmoji;
  RxBool? hasVoted;
  RxString? votedColor;
  RxBool? isBookmarked;
  RxBool isFollow = false.obs;

  PostModel({
    this.id,
    this.content,
    this.media,
    this.poll,
    this.postType,
    this.author,
    this.personName,
    this.personAge,
    this.personLocation,
    this.stats,
    this.isFollowing,
    this.createdAt,
    this.reactedEmoji,
    this.hasVoted,
    this.votedColor,
    this.isBookmarked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"] ?? "",
      content:
          json['content'] != null ? Content.fromJson(json['content']) : null,
      media:
          json['media'] != null
              ? (json['media'] as List).map((e) => Media.fromJson(e)).toList()
              : [],
      poll: json['poll'] != null ? Poll.fromJson(json['poll']) : null,
      postType: json["postType"] ?? "",
      author:
          json["author"] != null ? Author.fromJson(json["author"]) : Author(),
      personName: json["personName"] ?? "",
      personAge: json["personAge"] ?? "",
      personLocation: json["personLocation"] ?? "",
      stats: json["stats"] != null ? Stats.fromJson(json["stats"]) : Stats(),
      isFollowing: json["isFollowing"] ?? false,
      createdAt:
          json["createdAt"] != null
              ? DateTime.parse(json["createdAt"].toString())
              : DateTime.now(),
      reactedEmoji: RxString(json['reactedEmoji'] ?? ""),
      hasVoted: RxBool(json['hasVoted'] ?? false),
      votedColor: RxString(json['votedColor'] ?? ""),
      isBookmarked: RxBool(json['isBookmarked'] ?? false),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (content != null) {
      data['title'] = content?.title;
      data['text'] = content?.text;
    }
    data['postType'] = postType;
    if (poll != null) {
      data['poll'] = poll?.toJson();
    }
    if (personName != null) {
      data['personName'] = personName;
    }
    if (personAge != null) {
      data['personAge'] = personAge;
    }
    if (personLocation != null) {
      data['personLocation'] = personLocation;
    }
    return data;
  }
}

class Author {
  final String? id;
  final String? displayName;
  final String? avatar;

  Author({this.id, this.displayName, this.avatar});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json["id"] ?? "",
      displayName: json["displayName"] ?? "",
      avatar: json["avatar"] ?? "",
    );
  }
}

class Stats {
  final RxInt? reactionCount;
  final RxInt? comments;
  int? views;
  int? totalFlagVote;
  String? leadingFlag;
  RxInt? greenVotes;
  RxInt? redVotes;

  Stats({
    this.reactionCount,
    this.comments,
    this.views,
    this.totalFlagVote,
    this.leadingFlag,
    this.greenVotes,
    this.redVotes,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      reactionCount: RxInt(json['reactionCount'] ?? 0),
      comments: RxInt(json['comments'] ?? 0),
      views: json["views"] ?? 0,
      totalFlagVote: json["totalFlagVote"] ?? 0,
      leadingFlag: json["leadingFlag"] ?? "",
      greenVotes: RxInt(json["greenVotes"] ?? 0),
      redVotes: RxInt(json["redVotes"] ?? 0),
    );
  }
}

class Media {
  final String? type; // "image" | "video" | "audio"
  final String? url;
  final String? thumbnailUrl;
  final double? duration; // seconds
  final int? size; // bytes
  final Dimensions? dimensions;
  final Metadata? metadata;

  Media({
    this.type,
    this.url,
    this.thumbnailUrl,
    this.duration,
    this.size,
    this.dimensions,
    this.metadata,
  });

  factory Media.fromJson(json) {
    return Media(
      type: json['type'] ?? "",
      url: json['url'] ?? "",
      thumbnailUrl: json['thumbnailUrl'] ?? "",
      duration:
          (json['duration'] != null)
              ? (json['duration'] as num).toDouble()
              : null,
      size: json['size'] ?? 0,
      dimensions:
          json['dimensions'] != null
              ? Dimensions.fromJson(json['dimensions'])
              : null,
      metadata:
          json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
    );
  }
}

class Dimensions {
  final int width;
  final int height;

  Dimensions({required this.width, required this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }
}

class Metadata {
  final String? format;
  final String? quality;
  final bool? isProcessed;

  Metadata({this.format, this.quality, this.isProcessed});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      format: json['format'] as String?,
      quality: json['quality'] as String?,
      isProcessed: json['isProcessed'] as bool?,
    );
  }
}

class Poll {
  String? question;
  List<PollOptions>? options;
  bool? allowMultipleChoices;
  int? totalVotes;
  bool? isActive;
  DateTime? expiresAt;
  RxBool? hasVoted;
  RxString? selectedOptionId;

  Poll({
    this.question,
    this.allowMultipleChoices = false,
    this.totalVotes,
    this.isActive,
    this.options,
    this.expiresAt,
    this.hasVoted,
    this.selectedOptionId,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      question: json['question'] ?? "",
      totalVotes: json['totalVotes'] ?? 0,
      options:
          json['options'] != null
              ? List<PollOptions>.from(
                json['options'].map((x) => PollOptions.fromJson(x)),
              )
              : [],
      allowMultipleChoices: json['allowMultipleChoices'] ?? false,
      isActive: json['isActive'] ?? false,
      expiresAt:
          json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      hasVoted: RxBool(json['hasVoted'] ?? false),
      selectedOptionId: RxString(json['selectedOptionId'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (question != null) {
      data['question'] = question;
    }
    if (options != null) {
      data['options'] = options?.map((x) => x.text).toList();
    }
    if (allowMultipleChoices != null) {
      data['allowMultipleChoices'] = allowMultipleChoices;
    }
    if (isActive != null) {
      data['isActive'] = isActive;
    }
    if (expiresAt != null) {
      data['expiresAt'] = expiresAt;
    }
    return data;
  }
}

class PollOptions {
  String? id;
  String? text;
  int? voteCount;
  List? voters;
  Color? color;

  PollOptions({this.id, this.text, this.voteCount, this.voters, this.color});

  factory PollOptions.fromJson(Map<String, dynamic> json) {
    return PollOptions(
      id: json['id'] ?? "",
      text: json['text'] ?? "",
      voteCount: json['voteCount'] ?? 0,
      voters: json['voters'] != null ? List<dynamic>.from(json['voters']) : [],
    );
  }

  double getPercentage(double totalVotes) {
    if (totalVotes == 0) return 0.0;
    return (voteCount! / totalVotes) * 100;
  }
}

class Content {
  final String? title;
  final String? text;
  final Formatting? formatting;

  Content({this.title, this.text, this.formatting});

  Map<String, dynamic> toJson() {
    return {'title': title, 'text': text};
  }

  factory Content.fromJson(json) {
    return Content(
      title: json['title'] ?? "",
      text: json['text'] ?? "",
      formatting:
          json['formatting'] != null
              ? Formatting.fromJson(json['formatting'])
              : Formatting(),
    );
  }
}

class Formatting {
  final String? alignment;
  final bool? isBold;
  final String? font;

  Formatting({this.alignment, this.isBold, this.font});

  factory Formatting.fromJson(json) {
    return Formatting(
      alignment: json['alignment'] ?? "",
      isBold: json['isBold'] ?? false,
      font: json['font'] ?? "",
    );
  }
}
