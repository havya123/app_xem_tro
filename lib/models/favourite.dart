import 'dart:convert';

class Favourite {
  String roomId;
  String userId;
  String houseId;
  String houseAddress;
  Favourite({
    required this.houseId,
    required this.userId,
    required this.roomId,
    required this.houseAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'houseId': houseId,
      'userId': userId,
      'roomId': roomId,
      'houseAddress': houseAddress
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
        houseId: map['houseId'] ?? "",
        userId: map['userId'] ?? "",
        roomId: map['roomId'] ?? "",
        houseAddress: map['houseAddress'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source) =>
      Favourite.fromMap(json.decode(source) as Map<String, dynamic>);
}
