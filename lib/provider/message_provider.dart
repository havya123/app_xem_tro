import 'dart:async';

import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/models/message.dart';
import 'package:app_xem_tro/models/roomChat.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/repository/message_repository.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  List<Message> listMsg = [];
  String roomChatId = "";
  List data = [];
  List<User> receivers = [];

  StreamController<Map<String, dynamic>> messageController =
      StreamController<Map<String, dynamic>>.broadcast();
  Timer? timer;

  Future<void> createRoomChat(String userId, String landlordId) async {
    await MessageRepo().createChat(userId, landlordId).then((value) async {
      await loadRoomChat(userId);
    });
  }

  Future<void> getRoomChat(String userId, String lanlordId) async {
    String roomChat = await MessageRepo().getRoomChat(userId, lanlordId);
    roomChatId = roomChat;
    notifyListeners();
  }

  Future<List> loadRoomChat(
    String userId,
  ) async {
    try {
      User user;
      data.clear();
      receivers.clear();
      data = await MessageRepo().getListRoomChat(userId);
      List<RoomChat> roomChats = data[1];
      for (var index in roomChats) {
        if (userId == index.participantIds[1]) {
          user = await UserProvider().getUserDetail(index.participantIds[0]);
          receivers.add(user);
        } else {
          user = await UserProvider().getUserDetail(index.participantIds[1]);
          receivers.add(user);
        }
      }

      data.add(receivers);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadListMessage(String roomChatId) async {
    timer?.cancel();

    timer = Timer(const Duration(seconds: 1), () async {
      messageController.add({'status': statusCode.loading, 'data': listMsg});

      MessageRepo()
          .getListMessage(roomChatId)
          .listen((List<Message> listMessage) {
        messageController
            .add({'status': statusCode.success, 'data': listMessage});
      });
    });
  }

  Future<void> sendMessage(
      String roomChatId, String userId, String message) async {
    await MessageRepo().sendMessage(roomChatId, userId, message);
  }

  @override
  void dispose() {
    messageController.close();
    super.dispose();
  }
}
