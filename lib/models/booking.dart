import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Booking {
  String userId;
  String userName;
  String userPhone;
  String landlordId;
  String landlordName;
  String landlordPhone;
  String roomId;
  String date;
  String time;
  String status;
  String createdAt;
  String address;
  Booking({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.landlordId,
    required this.landlordName,
    required this.landlordPhone,
    required this.roomId,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'landlordId': landlordId,
      'landlordName': landlordName,
      'landlordPhone': landlordPhone,
      'roomId': roomId,
      'date': date,
      'time': time,
      'status': status,
      'createdAt': createdAt,
      'address': address
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
        userId: map['userId'] ?? "",
        userName: map['userName'] ?? "",
        userPhone: map['userPhone'] ?? "",
        landlordId: map['landlordId'] ?? "",
        landlordName: map['landlordName'] ?? "",
        landlordPhone: map['landlordPhone'] ?? "",
        roomId: map['roomId'] ?? "",
        date: map['date'] ?? "",
        time: map['time'] ?? "",
        status: map['status'] ?? "",
        createdAt: map['createdAt'] ?? "",
        address: map['address'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source) as Map<String, dynamic>);
}
