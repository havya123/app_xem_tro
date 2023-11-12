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

  User({
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.dob,
    required this.email,
    required this.address,
    this.avatar,
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
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
