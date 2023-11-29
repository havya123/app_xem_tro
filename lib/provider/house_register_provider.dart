import 'dart:io';

import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/repository/house_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HouseProvider extends ChangeNotifier {
  List<XFile?> selectedImageHouse = [];
  List<String> listDoc = [];

  int countImage = 0;

  void deleteImage(int index) {
    selectedImageHouse.removeAt(index);
    countImage = selectedImageHouse.length;
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
    countImage = selectedImageHouse.length;
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
    countImage = selectedImageHouse.length;
    notifyListeners();
  }

  Future<void> houseRegistration(
    String userName,
    String userPhone,
    String phoneNumber,
    String province,
    String district,
    String ward,
    String street,
    double lat,
    double lng,
    String facilities,
    String? description,
  ) async {
    await HouseRepo().houseRegistration(userName, userPhone, phoneNumber,
        province, district, ward, street, lat, lng, facilities, description);
  }

  Future<void> uploadImg(String userPhone) async {
    HouseRepo().uploadImg(userPhone, selectedImageHouse);
  }

  Future<List<House>> getListHouseLL(String userPhone) async {
    List listDocHouse = await HouseRepo().getListHouse(userPhone);
    listDoc = listDocHouse[0];
    List<House> listHouse = listDocHouse[1];
    return listHouse;
  }

  Future<List<House>> getListHouseUser() async {
    List<House> listHouse = await HouseRepo().getAllHouse();
    return listHouse;
  }
}
