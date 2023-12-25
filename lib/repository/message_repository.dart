import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/message.dart';
import 'package:app_xem_tro/models/roomChat.dart';
import 'package:intl/intl.dart';

class MessageRepo {
  Future<void> createChat(String userId, String landlordId) async {
    String createdAt = DateTime.now().toString();
    if (await checkRoomChatExist(userId, landlordId)) {
      return;
    }
    await FirebaseService.chatRoomRef.doc().set(RoomChat(
          participantIds: [userId, landlordId],
          createdAt: createdAt,
          lastMsg: "",
          lastSend: "",
        ));
  }

  Future<String> getRoomChat(String senderId, String receiverId) async {
    String roomChatId = await FirebaseService.chatRoomRef
        .where('participantIds', arrayContains: senderId)
        .get()
        .then((value) {
      for (var id in value.docs) {
        if (id.data().participantIds.contains(senderId) &&
            id.data().participantIds.contains(receiverId)) {
          return id.id;
        }
      }
      return "";
    });
    return roomChatId;
  }

  Future<bool> checkRoomChatExist(String userId, String landlord) async {
    var response = await FirebaseService.chatRoomRef.get();
    if (response.docs.isNotEmpty) {
      for (var document in response.docs) {
        if (document.data().participantIds.contains(userId) &&
            document.data().participantIds.contains(landlord)) {
          return true;
        }
      }
    }

    return false;
  }

  Future<void> sendMessage(
      String roomChatId, String userId, String message) async {
    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-dd - kk:mm:ss').format(now);
    await FirebaseService.chatRoomRef
        .doc(roomChatId)
        .collection('messages')
        .add(Message(userId: userId, message: message, createdAt: createdAt)
            .toMap())
        .then((value) async {
      await updateLastMsg(message, roomChatId, createdAt);
    });
  }

  Future<void> updateLastMsg(
      String message, String roomId, String createdAt) async {
    await FirebaseService.chatRoomRef.doc(roomId).update({
      'lastMsg': message,
      'lastSend': createdAt,
    });
  }

  Future<List> getListRoomChat(
    String userId,
  ) async {
    List<RoomChat> listRoomChat = [];
    List<String> listDocId = [];
    List data = [];
    await FirebaseService.chatRoomRef
        .where('participantIds', arrayContainsAny: [userId])
        .get()
        .then((value) {
          listDocId = value.docs.map((e) => e.id).toList();
          listRoomChat = value.docs.map((e) => e.data()).toList();
          data = [
            listDocId,
            listRoomChat,
          ];
        });
    return data;
  }

  Stream<List<Message>> getListMessage(String roomChatId) {
    List<Message> listMessage = [];
    return FirebaseService.chatRoomRef
        .doc(roomChatId)
        .collection('messages')
        .snapshots()
        .map((event) {
      listMessage = event.docs.map((e) => Message.fromMap(e.data())).toList();
      listMessage.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return listMessage;
    });
  }
}
