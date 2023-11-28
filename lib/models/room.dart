import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Room {
  String roomId;
  String utilities;
  String numberOfPeople;
  String numberOfFloor;
  String acreage;
  String? img;
  String createAt;
  String price;
  Room({
    required this.roomId,
    required this.utilities,
    required this.numberOfPeople,
    required this.numberOfFloor,
    required this.acreage,
    this.img,
    required this.createAt,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'utilities': utilities,
      'numberOfPeople': numberOfPeople,
      'numberOfFloor': numberOfFloor,
      'acreage': acreage,
      'img': img,
      'createAt': createAt,
      'price': price,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      roomId: map['roomId'] as String,
      utilities: map['utilities'] as String,
      numberOfPeople: map['numberOfPeople'] as String,
      numberOfFloor: map['numberOfFloor'] as String,
      acreage: map['acreage'] as String,
      img: map['img'] != null ? map['img'] as String : null,
      createAt: map['createAt'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);
}
