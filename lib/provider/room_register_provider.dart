import 'dart:async';
import 'dart:io';

import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/repository/room_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RoomRegisterProvider extends ChangeNotifier {
  List<XFile?> selectedImageRoom = [];
  List<Room> listRoom = [];
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
      if (response.isNotEmpty) {
        listRoom.clear();
        listRoom = response;
        roomController.add({'status': statusCode.success, 'data': listRoom});
      } else {
        roomController.add({'status': statusCode.error, 'data': []});
      }
    });
  }

  @override
  void dispose() {
    roomController.close();
    super.dispose();
  }
}
