import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomChat {
  List<String> participantIds;
  String lastMsg;
  String lastSend;
  String createdAt;
  RoomChat({
    required this.participantIds,
    required this.lastMsg,
    required this.lastSend,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'participantIds': participantIds,
      'lastMsg': lastMsg,
      'lastSend': lastSend,
      'createdAt': createdAt,
    };
  }

  factory RoomChat.fromMap(Map<String, dynamic> map) {
    return RoomChat(
      lastMsg: map['lastMsg'] ?? "",
      createdAt: map['roomId'] ?? "",
      lastSend: map['lastSend'] ?? "",
      participantIds: List<String>.from(map['participantIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomChat.fromJson(String source) =>
      RoomChat.fromMap(json.decode(source) as Map<String, dynamic>);
}
