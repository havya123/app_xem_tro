import 'dart:async';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/repository/house_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HouseProvider extends ChangeNotifier {
  List<XFile?> selectedImageHouse = [];
  List<String> listDoc = [];
  List<House> listHouse = [];
  int countImage = 0;
  Timer? timer;
  StreamController<Map> houseController = StreamController<Map>.broadcast();

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
    String houseName,
    String province,
    String district,
    String ward,
    String street,
    double lat,
    double lng,
    String facilities,
    String? description,
  ) async {
    await HouseRepo()
        .houseRegistration(userName, userPhone, phoneNumber, houseName,
            province, district, ward, street, lat, lng, facilities, description)
        .then((value) {
      getListHouseLL(userPhone);
    });
  }

  Future<void> uploadImg(String userPhone) async {
    await HouseRepo().uploadImg(userPhone, selectedImageHouse);
  }

  Future<void> getListHouseLL(String userPhone) async {
    timer?.cancel();
    timer = Timer(const Duration(seconds: 1), () async {
      houseController.add({'status': statusCode.loading, 'data': []});
      var response = await HouseRepo().getListHouse(userPhone);
      if (response.isNotEmpty) {
        listHouse.clear();
        listHouse = response[1];
        listDoc = response[0];
        houseController.add({'status': statusCode.success, 'data': listHouse});
      } else {
        houseController.add({'status': statusCode.error, 'data': []});
      }
    });
  }

  Future<List> getAllHouse() async {
    List listData = await HouseRepo().getAllHouse();
    return listData;
  }

  Future<List> getListHouseNearBy(String address) async {
    List response = await HouseRepo().getListHouseNearBy(address);
    return response;
  }

  Future<House> getHouseDetail(String id) async {
    House house = await HouseRepo().getHouseDetail(id);
    return house;
  }

  @override
  void dispose() {
    houseController.close();
    super.dispose();
  }
}
