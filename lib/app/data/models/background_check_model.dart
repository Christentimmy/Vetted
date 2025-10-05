class BackgroundCheckModel {
  final String id;
  final String name;
  final String dob;
  final int age;
  final List<String> address;
  final List<String> phoneNumbers;
  final List<String> emails;
  final List<Relative> relatives;

  BackgroundCheckModel({
    required this.id,
    required this.name,
    required this.dob,
    required this.age,
    required this.address,
    required this.phoneNumbers,
    required this.emails,
    required this.relatives,
  });

  factory BackgroundCheckModel.fromJson(Map<String, dynamic> json) {
    return BackgroundCheckModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      dob: json['dateOfBirth'] ?? '',
      age: json['age'] ?? 0,
      address: List<String>.from(json['address'] ?? []),
      phoneNumbers: List<String>.from(json['phoneNumbers'] ?? []),
      emails: List<String>.from(json['email'] ?? []),
      relatives:
          json['relatives'] != null
              ? (json['relatives'] as List<dynamic>)
                  .map((e) => Relative.fromJson(e))
                  .toList()
              : <Relative>[],
    );
  }
}

class Relative {
  final String name;
  final String relativeType;

  Relative({required this.name, required this.relativeType});

  factory Relative.fromJson(Map<String, dynamic> json) {
    return Relative(
      name: json['name'] ?? '',
      relativeType: json['relativeType'] ?? '',
    );
  }
}
