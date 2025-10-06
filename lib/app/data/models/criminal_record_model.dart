
class CriminalRecord {
  final String? name;
  final List<OffenderAttribute>? offenderAttributes;
  final CaseDetails? caseDetails;
  final String? offense;
  final String? image;

  CriminalRecord({
    this.name,
    this.offenderAttributes,
    this.caseDetails,
    this.offense,
    this.image,
  });

  factory CriminalRecord.fromJson(Map<String, dynamic> json) {
    return CriminalRecord(
      name: json['name'] ?? '',
      offenderAttributes: (json['offenderAttributes'] as List<dynamic>?)
              ?.map((e) => OffenderAttribute.fromJson(e))
              .toList() ??
          [],
      caseDetails: json['caseDetails'] != null
          ? CaseDetails.fromJson(json['caseDetails'])
          : null,
      offense: json['offense'] ?? "",
      image: json['image'] ?? "",
    );
  }
}

class OffenderAttribute {
  final String? dob;
  final String? age;
  final String? birthState;
  final String? hair;
  final String? eye;
  final String? height;
  final String? weight;
  final String? race;
  final String? sex;
  final String? skinTone;
  final String? militaryService;
  final String? scarsMarks;
  final String? sourceMap;

  OffenderAttribute({
    this.dob,
    this.age,
    this.birthState,
    this.hair,
    this.eye,
    this.height,
    this.weight,
    this.race,
    this.sex,
    this.skinTone,
    this.militaryService,
    this.scarsMarks,
    this.sourceMap,
  });

  factory OffenderAttribute.fromJson(Map<String, dynamic> json) {
    return OffenderAttribute(
      dob: json['dob'] ?? "",
      age: json['age']?.toString(),
      birthState: json['birthState'] ?? "",
      hair: json['hair'] ?? "",
      eye: json['eye'] ?? "",
      height: json['height'] ?? "",
      weight: json['weight'] ?? "",
      race: json['race'] ?? "",
      sex: json['sex'] ?? "",
      skinTone: json['skinTone'] ?? "",
      militaryService: json['militaryService'] ?? "",
      scarsMarks: json['scarsMarks'] ?? "",
      sourceMap: json['sourceMap'] ?? "",
    );
  }
}

class CaseDetails {
  final String? caseNumber;
  final String? rawCategory;
  final String? courtCounty;
  final String? fees;
  final String? fines;
  final String? caseDate;

  CaseDetails({
    this.caseNumber,
    this.rawCategory,
    this.courtCounty,
    this.fees,
    this.fines,
    this.caseDate,
  });

  factory CaseDetails.fromJson(Map<String, dynamic> json) {
    return CaseDetails(
      caseNumber: json['caseNumber'] ?? "",
      rawCategory: json['rawCategory'] ?? "",
      courtCounty: json['courtCounty'] ?? "",
      fees: json['fees']?.toString(),
      fines: json['fines']?.toString(),
      caseDate: json['caseDate'] ?? "",
    );
  }
}
