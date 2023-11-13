import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ward {
  String name;
  int code;
  String divistionType;
  String codeName;
  int districtCode;
  Ward({
    required this.name,
    required this.code,
    required this.codeName,
    required this.divistionType,
    required this.districtCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'codename': codeName,
      'division_type': divistionType,
      'district_code': districtCode,
    };
  }

  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      name: map['name'] as String,
      code: map['code'] as int,
      codeName: map['codename'] as String,
      divistionType: map['division_type'] as String,
      districtCode: map['district_code'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ward.fromJson(String source) =>
      Ward.fromMap(json.decode(source) as Map<String, dynamic>);
}
