import 'dart:convert';

class Favourite {
  String houseId;
  String userId;
  Favourite({
    required this.houseId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'houseId': houseId,
      'userId': userId,
    };
  }

  factory Favourite.fromMap(Map<String, dynamic> map) {
    return Favourite(
      houseId: map['houseId'] ?? "",
      userId: map['userId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Favourite.fromJson(String source) =>
      Favourite.fromMap(json.decode(source) as Map<String, dynamic>);
}
