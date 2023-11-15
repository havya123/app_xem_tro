import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HouseRegisterProvider extends ChangeNotifier {
  List<XFile?> selectedImageHouse = [];
  List<XFile?> selectedImageRoom = [];

  void deleteImage(int index) {
    selectedImageHouse.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImageHouseFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedImageHouse.add(returnImage);
    notifyListeners();
  }

  Future<void> pickImageHouseFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    selectedImageHouse.add(returnImage);
    notifyListeners();
  }

  void deleteImageRoom(int index) {
    selectedImageRoom.removeAt(index);
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
    notifyListeners();
  }
}
