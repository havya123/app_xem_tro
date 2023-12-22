import 'dart:async';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/repository/room_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RoomRegisterProvider extends ChangeNotifier {
  List<XFile?> selectedImageRoom = [];
  List<Room> listRoom = [];
  List<String> listRoomId = [];
  Timer? timer;
  StreamController<Map> roomController = StreamController<Map>.broadcast();
  int countItem = 0;

  Future<void> roomRegistration(
      String houseId,
      String roomId,
      String userPhone,
      String utilities,
      String numberOfPeople,
      String numberOfFloor,
      String acreage,
      String? img,
      String price) async {
    await RoomRepo()
        .roomRegistration(houseId, roomId, utilities, numberOfPeople,
            numberOfFloor, acreage, img, price)
        .then((value) => getListRoom(houseId));
  }

  void deleteImageRoom(int index) {
    selectedImageRoom.removeAt(index);
    countItem = selectedImageRoom.length;
    notifyListeners();
  }

  Future<Room> getRoomDetail(String roomId) async {
    Room room = await FirebaseService.roomRef.doc(roomId).get().then((value) {
      return value.data() as Room;
    });
    return room;
  }

  Future<void> pickImageRoomFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedImageRoom.add(returnImage);
    countItem = selectedImageRoom.length;
    notifyListeners();
  }

  Future<void> pickImageRoomFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    selectedImageRoom.add(returnImage);
    countItem = selectedImageRoom.length;
    notifyListeners();
  }

  Future<void> uploadImg(String userPhone, String houseId) async {
    await RoomRepo().uploadImg(userPhone, selectedImageRoom, houseId);
  }

  Future<void> getListRoom(String houseId) async {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), () async {
      roomController.add({'status': statusCode.loading, 'data': []});
      var response = await RoomRepo().getListRoom(houseId);
      List<Room> rooms = response[1];
      List<String> listId = response[0];
      if (response.isNotEmpty) {
        listRoom.clear();
        listRoom = rooms;
        listRoomId = listId;
        roomController.add({'status': statusCode.success, 'data': listRoom});
      } else {
        roomController.add({'status': statusCode.error, 'data': []});
      }
    });
  }

  Future<void> getListRoomLandlord(String houseId) async {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), () async {
      roomController.add({'status': statusCode.loading, 'data': []});
      var response = await RoomRepo().getListRoomLandlord(houseId);
      List<Room> rooms = response[1];
      List<String> listId = response[0];
      if (response.isNotEmpty) {
        listRoom.clear();
        listRoom = rooms;
        listRoomId = listId;
        roomController.add({'status': statusCode.success, 'data': listRoom});
      } else {
        roomController.add({'status': statusCode.error, 'data': []});
      }
    });
  }

  Future<User> getLandLord(String houseId) async {
    User user = await RoomRepo().getUser(houseId) as User;
    return user;
  }

  Future<void> bookedRoomStatus(String roomId) async {
    await RoomRepo().bookedStatusRoom(roomId);
  }

  Future<void> availableRoomStatus(String roomId) async {
    await RoomRepo().availableStatusRoom(roomId);
  }

  @override
  void dispose() {
    roomController.close();
    super.dispose();
  }
}
