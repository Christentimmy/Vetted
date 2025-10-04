class EniformPhoneInfoModel {
  final String fullName;
  final String age;
  final List<String> emails;
  final bool isEmailValidated;
  final bool isBusiness;
  final List<String> address;

  EniformPhoneInfoModel({
    required this.fullName,
    required this.age,
    required this.emails,
    required this.isEmailValidated,
    required this.isBusiness,
    required this.address,
  });

  factory EniformPhoneInfoModel.fromJson(Map<String, dynamic> json) {
    return EniformPhoneInfoModel(
      fullName: json['full_name'] ?? '',
      age: json['age'] ?? '',
      emails: (json['emails'] as List<dynamic>?)?.cast<String>().toList() ?? <String>[],
      isEmailValidated: json['is_email_validated'] ?? false,
      isBusiness: json['is_business'] ?? false,
      address: (json['address'] as List<dynamic>?)?.cast<String>().toList() ?? <String>[],
    );
  }
}
