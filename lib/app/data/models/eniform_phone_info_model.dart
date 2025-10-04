import 'package:google_maps_flutter/google_maps_flutter.dart';

class EniformPhoneInfoModel {
  String? fullName;
  String? age;
  List<String>? emails;
  bool? isEmailValidated;
  bool? isBusiness;
  List<String>? address;

  EniformPhoneInfoModel({
    this.fullName,
    this.age,
    this.emails,
    this.isEmailValidated,
    this.isBusiness,
    this.address,
  });

  factory EniformPhoneInfoModel.fromJson(Map<String, dynamic> json) {
    return EniformPhoneInfoModel(
      fullName: json['fullName'] ?? '',
      age: json['age'].toString(),
      emails:
          (json['emails'] as List<dynamic>?)?.cast<String>().toList() ??
          <String>[],
      isEmailValidated: json['isEmailValidated'] ?? false,
      isBusiness: json['isBusiness'] ?? false,
      address:
          (json['address'] as List<dynamic>?)?.cast<String>().toList() ??
          <String>[],
    );
  }
}

class ReverseInfoOnPhoneSearchModel {
  String? fullName;
  String? age;
  String? phone;
  List<EniformReversePhoneModel>? phones;
  String? carrier;
  LatLng? coordinates;

  ReverseInfoOnPhoneSearchModel({
    this.fullName,
    this.age,
    this.phone,
    this.phones,
    this.carrier,
    this.coordinates,
  });

  factory ReverseInfoOnPhoneSearchModel.fromJson(Map<String, dynamic> json) {
    return ReverseInfoOnPhoneSearchModel(
      fullName: json['fullName'] ?? '',
      age: json['age'].toString(),
      phone: json['phone'] ?? '',
      phones:
          json["phones"] != null
              ? List.from(
                json["phones"],
              ).map((e) => EniformReversePhoneModel.fromJson(e)).toList()
              : [],
      carrier: json['carrier'] ?? '',
      coordinates: LatLng(
        double.tryParse(json['coordinates']['lat'].toString()) ?? 0.0,
        double.tryParse(json['coordinates']['lng'].toString()) ?? 0.0,
      ),
    );
  }
}

class EniformReversePhoneModel {
  final String number;
  final String type;
  final String company;
  final String location;

  EniformReversePhoneModel({
    required this.number,
    required this.type,
    required this.company,
    required this.location,
  });

  factory EniformReversePhoneModel.fromJson(Map<String, dynamic> json) {
    return EniformReversePhoneModel(
      number: json['number'] ?? '',
      type: json['type'] ?? '',
      company: json['company'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
