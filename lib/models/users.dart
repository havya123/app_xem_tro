import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String password;
  String name;
  String phoneNumber;
  String dob;
  String email;
  String address;
  String? avatar;
  String token;
  int role;
  String createdAt;
  String gender;

  User({
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.dob,
    required this.email,
    required this.address,
    required this.token,
    required this.role,
    this.avatar,
    required this.createdAt,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'name': name,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'email': email,
      'address': address,
      'avatar': avatar,
      'token': token,
      'role': role,
      'createdAt': createdAt,
      'gender': gender
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        password: map['password'] ?? "",
        name: map['name'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        dob: map['dob'] ?? "",
        email: map['email'] ?? "",
        address: map['address'] ?? "",
        avatar: map['avatar'] ?? "",
        token: map['token'] ?? "",
        role: map['role'] as int,
        createdAt: map['createdAt'] ?? "",
        gender: map['gender'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
