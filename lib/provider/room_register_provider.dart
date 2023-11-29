import 'dart:io';

import 'package:app_xem_tro/repository/room_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RoomRegisterProvider extends ChangeNotifier {
  List<XFile?> selectedImageRoom = [];

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
    await RoomRepo().roomRegistration(houseId, roomId, utilities,
        numberOfPeople, numberOfFloor, acreage, img, price);
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

  Future<void> uploadImg(String userPhone) async {
    RoomRepo().uploadImg(userPhone, File(selectedImageRoom.first!.path));
  }
}
