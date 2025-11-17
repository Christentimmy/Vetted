class UserModel {
  final String? id;
  final String? phone;
  final String? email;
  final bool? isPremium;
  final String? role;
  final String? bio;
  final String? accountStatus;
  final bool? isPhoneVerified;
  final bool? isProfileCompleted;
  final String? relationshipStatus;
  final String? displayName;
  final DateTime? dateOfBirth;
  final DateTime? updatedAt;
  final String? avatar;
  final int? followerCount;
  final int? followingCount;
  final LocationModel? location;
  final Subscription? subscription;

  final String? inviteCode;
  final String? totalInvites;
  final String? premiumCredits;
  final NotificationSettings? notificationSettings;

  UserModel({
    this.id,
    this.phone,
    this.email,
    this.isPremium,
    this.role,
    this.bio,
    this.accountStatus,
    this.isPhoneVerified,
    this.isProfileCompleted,
    this.relationshipStatus,
    this.displayName,
    this.dateOfBirth,
    this.updatedAt,
    this.avatar,
    this.followerCount,
    this.followingCount,
    this.location,
    this.subscription,

    this.inviteCode,
    this.totalInvites,
    this.premiumCredits,
    this.notificationSettings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      isPremium: (json['subscription']?["status"] ?? "") == "active",
      role: json['role'] ?? '',
      bio: json['bio'] ?? '',
      accountStatus: json['accountStatus'] ?? '',
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      relationshipStatus: json['relationshipStatus'] ?? '',
      displayName: json['displayName'] ?? '',
      dateOfBirth:
          DateTime.tryParse(json['dateOfBirth'].toString()) ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now(),
      avatar: json['avatar'] ?? '',
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      location:
          json['location'] != null
              ? LocationModel.fromJson(json['location'])
              : null,
      subscription:
          json['subscription'] != null
              ? Subscription.fromJson(json['subscription'])
              : null,

      inviteCode: json['inviteCode']?.toString() ?? '',
      totalInvites: json['totalInvites']?.toString() ?? '',
      premiumCredits: json['premiumCredits']?.toString() ?? '',
      notificationSettings:
          json['notificationSettings'] != null
              ? NotificationSettings.fromJson(json['notificationSettings'])
              : NotificationSettings(),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, phone: $phone, role: $role, displayName: $displayName, followerCount: $followerCount, followingCount: $followingCount, location: $location)';
  }
}

class LocationModel {
  String? type;
  String? address;
  List<double>? coordinates;

  LocationModel({this.type, this.address, this.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      coordinates:
          (json['coordinates'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'address': address, 'coordinates': coordinates};
  }

  @override
  String toString() {
    return 'LocationModel(type: $type, address: $address, coordinates: $coordinates)';
  }
}

class Subscription {
  String? planId;
  String? status;
  DateTime? currentPeriodEnd;
  bool? cancelAtPeriodEnd;

  Subscription({
    this.planId,
    this.status,
    this.currentPeriodEnd,
    this.cancelAtPeriodEnd,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      planId: json['planId'] ?? '',
      status: json['status'] ?? '',
      currentPeriodEnd:
          DateTime.tryParse(json['currentPeriodEnd'].toString()) ??
          DateTime.now(),
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] ?? false,
    );
  }
}

class NotificationSettings {
  bool? general;
  bool? trendingPost;
  bool? newComments;
  bool? alertForWomenNames;
  bool? reactions;

  NotificationSettings({
    this.general,
    this.trendingPost,
    this.newComments,
    this.alertForWomenNames,
    this.reactions,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      general: json['general'] ?? false,
      trendingPost: json['trendingPost'] ?? false,
      newComments: json['newComments'] ?? false,
      alertForWomenNames: json['alertForWomenNames'] ?? false,
      reactions: json['reactions'] ?? false,
    );
  }
}
