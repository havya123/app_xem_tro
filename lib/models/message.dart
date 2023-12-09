import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String userId;
  String message;
  String createdAt;
  Message({
    required this.userId,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'message': message,
      'createdAt': createdAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      userId: map['userId'] as String,
      message: map['message'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
