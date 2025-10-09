

class OffenderModel {
  final String sexOffenderState;
  final String sexOffenderLocation;
  final String sexOffenderZipcode;
  final double sexOffenderLat;
  final double sexOffenderLon;
  final String sexOffenderName;
  final String sexOffenderFirstName;
  final String sexOffenderMiddleName;
  final String sexOffenderLastName;
  final DateTime sexOffenderBirthdate;
  final int sexOffenderAge;
  final String sexOffenderAddressLine1;
  final String sexOffenderAddressLine2;
  final String sexOffenderSex;
  final String sexOffenderRace;
  final String sexOffenderHeight;
  final String sexOffenderWeight;
  final String sexOffenderHair;
  final String sexOffenderEyes;
  final String sexOffenderMarks;
  final String sexOffenderAliases;
  final String sexOffenderCharges;
  final String sexOffenderChanges;
  final bool sexOffenderIsPredator;
  final bool sexOffenderIsAbsconder;
  final String sexOffenderImageUrl;
  final String riskLevel;

  OffenderModel({
    required this.sexOffenderState,
    required this.sexOffenderLocation,
    required this.sexOffenderZipcode,
    required this.sexOffenderLat,
    required this.sexOffenderLon,
    required this.sexOffenderName,
    required this.sexOffenderFirstName,
    required this.sexOffenderMiddleName,
    required this.sexOffenderLastName,
    required this.sexOffenderBirthdate,
    required this.sexOffenderAge,
    required this.sexOffenderAddressLine1,
    required this.sexOffenderAddressLine2,
    required this.sexOffenderSex,
    required this.sexOffenderRace,
    required this.sexOffenderHeight,
    required this.sexOffenderWeight,
    required this.sexOffenderHair,
    required this.sexOffenderEyes,
    required this.sexOffenderMarks,
    required this.sexOffenderAliases,
    required this.sexOffenderCharges,
    required this.sexOffenderChanges,
    required this.sexOffenderIsPredator,
    required this.sexOffenderIsAbsconder,
    required this.sexOffenderImageUrl,
    required this.riskLevel,
  });

  factory OffenderModel.fromJson(Map<String, dynamic> json) {
    return OffenderModel(
      sexOffenderState: json['state'] ?? '',
      sexOffenderLocation: json['sex_offender_location'] ?? '',
      sexOffenderZipcode: json['zipcode'] ?? '',
      sexOffenderLat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      sexOffenderLon: (json['lng'] as num?)?.toDouble() ?? 0.0,
      sexOffenderName: json['name'] ?? '',
      sexOffenderFirstName: json['firstName'] ?? '',
      sexOffenderMiddleName: json['middleName'] ?? '',
      sexOffenderLastName: json['lastName'] ?? '',
      sexOffenderBirthdate: DateTime.tryParse(json['dob'] ?? '') ?? DateTime(1970),
      sexOffenderAge: int.tryParse(json['age'].toString()) ?? 0,
      sexOffenderAddressLine1: json['address'] ?? '',
      sexOffenderAddressLine2: json[''] ?? '',
      sexOffenderSex: json['sex'] ?? '',
      sexOffenderRace: json['race'] ?? '',
      sexOffenderHeight: json['height'] ?? '',
      sexOffenderWeight: json['weight'] ?? '',
      sexOffenderHair: json['hairColor'] ?? '',
      sexOffenderEyes: json['eyeColor'] ?? '',
      sexOffenderMarks: json['marks'] ?? '',
      sexOffenderAliases: json[''] ?? '',
      sexOffenderCharges: json['crime'] ?? '',
      sexOffenderChanges: json[''] ?? '',
      sexOffenderIsPredator: json['isPredator'] == true,
      sexOffenderIsAbsconder: json['isAbsconder'] == true,
      sexOffenderImageUrl: json['offenderImageUrl'] ?? '',
      riskLevel: json['riskLevel'] ?? '',
    );
  }
}
