class AddressModel {
  final String id;
  final String address;

  AddressModel({required this.id, required this.address});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(id: json['id'] ?? '', address: json['address'] ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id, 'address': address};
}

class PhoneModel {
  final String number;
  final String type;
  final int score;

  PhoneModel({required this.number, required this.type, required this.score});

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    return PhoneModel(
      number: json['number'] ?? '',
      type: json['type'] ?? '',
      score: json['score'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'type': type,
    'score': score,
  };
}

class PersonModel {
  final String id;
  final String name;
  final bool isDead;
  final String currentAddresses;
  final List<dynamic> ownedProperties;
  final List<String> phones;
  final List<String> emails;
  final String dateOfBirth;
  final String? linkedinUrl;
  final String? companyName;
  final String? jobTitle;
  final List<String>? relatives;

  PersonModel({
    required this.id,
    required this.name,
    required this.isDead,
    required this.currentAddresses,
    required this.ownedProperties,
    required this.phones,
    required this.emails,
    required this.dateOfBirth,
    this.linkedinUrl,
    this.companyName,
    this.jobTitle,
    this.relatives,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isDead: json['is_dead'] ?? false,
      currentAddresses: json["current_addresses"] ?? "",
      ownedProperties: json['owned_properties'] ?? [],
      // phones:
      //     (json['phones'] as List<dynamic>? ?? [])
      //         .map((e) => PhoneModel.fromJson(e))
      //         .toList(),
      phones:
          json["phones"] != null
              ? (json['phones'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : [],
      emails: (json['emails'] as List<dynamic>? ?? []).cast<String>(),
      dateOfBirth: json['date_of_birth'] ?? '',
      linkedinUrl: json['linkedin_url'],
      companyName: json['company_name'],
      jobTitle: json['job_title'],
      relatives:
          json["relatives"] != null
              ? (json["relatives"] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : [],
    );
  }
}
