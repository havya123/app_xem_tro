import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class District {
  String name;
  int code;
  String divisionType;
  String codeName;
  int proviceCode;
  District({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codeName,
    required this.proviceCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'division_type': divisionType,
      'codename': codeName,
      'province_code': proviceCode,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      name: map['name'] as String,
      code: map['code'] as int,
      divisionType: map['division_type'] as String,
      codeName: map['codename'] as String,
      proviceCode: map['province_code'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory District.fromJson(String source) =>
      District.fromMap(json.decode(source) as Map<String, dynamic>);
}
