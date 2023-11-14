import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Province {
  String name;
  int code;
  String divisionType;
  String codeName;
  int phoneCode;
  Province({
    required this.name,
    required this.code,
    required this.divisionType,
    required this.codeName,
    required this.phoneCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'division_type': divisionType,
      'codename': codeName,
      'phone_code': phoneCode,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      name: map['name'] as String,
      code: map['code'] as int,
      divisionType: map['division_type'] as String,
      codeName: map['codename'] as String,
      phoneCode: map['phone_code'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Province.fromJson(String source) =>
      Province.fromMap(json.decode(source) as Map<String, dynamic>);
}
