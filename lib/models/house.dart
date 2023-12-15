import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class House {
  String userName;
  String userPhone;
  String phoneNumber;
  String houseName;
  String province;
  String district;
  String ward;
  String street;
  double lat;
  double lng;
  String facilities;
  String? description;
  String? img;
  String createdAt;
  String status;
  String fullAddress;
  House(
      {required this.userName,
      required this.userPhone,
      required this.phoneNumber,
      required this.houseName,
      required this.province,
      required this.district,
      required this.ward,
      required this.street,
      required this.lat,
      required this.lng,
      required this.facilities,
      this.description,
      this.img,
      required this.createdAt,
      required this.status,
      required this.fullAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userPhone': userPhone,
      'phoneNumber': phoneNumber,
      'houseName': houseName,
      'province': province,
      'district': district,
      'ward': ward,
      'street': street,
      'lat': lat,
      'lng': lng,
      'facilities': facilities,
      'description': description,
      'img': img,
      'createdAt': createdAt,
      'status': status,
      'fullAddress': fullAddress,
    };
  }

  factory House.fromMap(Map<String, dynamic> map) {
    return House(
      userName: map['userName'] ?? "",
      userPhone: map['userPhone'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      houseName: map['houseName'] ?? "",
      province: map['province'] ?? "",
      district: map['district'] ?? "",
      ward: map['ward'] ?? "",
      street: map['street'] ?? "",
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
      facilities: map['facilities'] ?? "",
      description: map['description'] ?? "",
      img: map['img'] ?? "",
      createdAt: map['createdAt'] ?? "",
      status: map['status'] ?? "",
      fullAddress: map['fullAddress'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory House.fromJson(String source) =>
      House.fromMap(json.decode(source) as Map<String, dynamic>);
}
