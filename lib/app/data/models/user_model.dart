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
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, phone: $phone, role: $role, displayName: $displayName, followerCount: $followerCount, followingCount: $followingCount, location: $location)';
  }
}

class LocationModel {
  final String? type;
  final String? address;
  final List<double>? coordinates;

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
