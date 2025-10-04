

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
  final DateTime sexOffenderLastUpdated;
  final DateTime sexOffenderCreated;
  final DateTime sexOffenderLastSynced;
  final bool sexOffenderIsSynced;

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
    required this.sexOffenderLastUpdated,
    required this.sexOffenderCreated,
    required this.sexOffenderLastSynced,
    required this.sexOffenderIsSynced,
  });

  factory OffenderModel.fromJson(Map<String, dynamic> json) {
    return OffenderModel(
      sexOffenderState: json['sex_offender_state'] ?? '',
      sexOffenderLocation: json['sex_offender_location'] ?? '',
      sexOffenderZipcode: json['sex_offender_zipcode'] ?? '',
      sexOffenderLat: (json['sex_offender_lat'] as num?)?.toDouble() ?? 0.0,
      sexOffenderLon: (json['sex_offender_lon'] as num?)?.toDouble() ?? 0.0,
      sexOffenderName: json['sex_offender_name'] ?? '',
      sexOffenderFirstName: json['sex_offender_first_name'] ?? '',
      sexOffenderMiddleName: json['sex_offender_middle_name'] ?? '',
      sexOffenderLastName: json['sex_offender_last_name'] ?? '',
      sexOffenderBirthdate: DateTime.tryParse(json['sex_offender_birthdate'] ?? '') ?? DateTime(1970),
      sexOffenderAge: json['sex_offender_age'] ?? 0,
      sexOffenderAddressLine1: json['sex_offender_address_line1'] ?? '',
      sexOffenderAddressLine2: json['sex_offender_address_line2'] ?? '',
      sexOffenderSex: json['sex_offender_sex'] ?? '',
      sexOffenderRace: json['sex_offender_race'] ?? '',
      sexOffenderHeight: json['sex_offender_height'] ?? '',
      sexOffenderWeight: json['sex_offender_weight'] ?? '',
      sexOffenderHair: json['sex_offender_hair'] ?? '',
      sexOffenderEyes: json['sex_offender_eyes'] ?? '',
      sexOffenderMarks: json['sex_offender_marks'] ?? '',
      sexOffenderAliases: json['sex_offender_aliases'] ?? '',
      sexOffenderCharges: json['sex_offender_charges'] ?? '',
      sexOffenderChanges: json['sex_offender_changes'] ?? '',
      sexOffenderIsPredator: json['sex_offender_is_predator'] == 'true' || json['sex_offender_is_predator'] == true,
      sexOffenderIsAbsconder: json['sex_offender_is_absconder'] == 'true' || json['sex_offender_is_absconder'] == true,
      sexOffenderImageUrl: json['sex_offender_image_url'] ?? '',
      sexOffenderLastUpdated: DateTime.tryParse(json['sex_offender_last_updated'] ?? '') ?? DateTime(1970),
      sexOffenderCreated: DateTime.tryParse(json['sex_offender_created'] ?? '') ?? DateTime(1970),
      sexOffenderLastSynced: DateTime.tryParse(json['sex_offender_last_synced'] ?? '') ?? DateTime(1970),
      sexOffenderIsSynced: json['sex_offender_is_synced'] == true,
    );
  }
}
