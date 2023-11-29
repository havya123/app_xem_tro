import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HouseRepo {
  static String createdAt = "";
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
    currentDate();

    FirebaseService.houseRef.doc().set(House(
        userName: userName,
        phoneNumber: phoneNumber,
        province: province,
        district: district,
        ward: ward,
        street: street,
        lat: lat,
        lng: lng,
        facilities: facilities,
        description: description ?? "",
        img: "",
        createdAt: createdAt,
        userPhone: userPhone));
  }

  Future<void> uploadImg(String userPhone, List<XFile?> listXFile) async {
    List<String> fileName =
        listXFile.map((e) => e!.path.split("/").last).toList();

    try {
      for (int i = 0; i < listXFile.length; i++) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('images/landlord/$userPhone/house/${fileName[i]}');

        await ref.putFile(File(listXFile[i]!.path));

        String downloadURL = await ref.getDownloadURL();
        updateImg(downloadURL, userPhone);
      }
    } catch (e) {}
  }

  Future<void> updateImg(String urlImg, String userPhone) async {
    await FirebaseFirestore.instance
        .collection('house')
        .where("createdAt", isEqualTo: createdAt)
        .where("userPhone", isEqualTo: userPhone)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('house')
          .doc(value.docs.first.id)
          .get()
          .then((value1) async {
        Map<String, dynamic>? response = value1.data();
        String currentImage = response?['img'];
        String addImg = "";
        if (currentImage.isEmpty) {
          addImg = urlImg;
        } else {
          addImg = "$currentImage, $urlImg";
        }
        FirebaseFirestore.instance
            .collection('house')
            .doc(value.docs.first.id)
            .update({'img': addImg});
      });
    });
  }

  void currentDate() {
    DateTime timeNow = DateTime.now();
    createdAt = timeNow.toString();
  }

  Future<List<House>> getListHouse(String userPhone) async {
    List<House> listHouse = [];
    await FirebaseFirestore.instance
        .collection('house')
        .where('userPhone', isEqualTo: userPhone)
        .get()
        .then((value) {
      listHouse = value.docs.map((e) => House.fromMap(e.data())).toList();
    });
    return listHouse;
  }

  Future<List<House>> getAllHouse() async {
    List<House> listHouse = [];
    await FirebaseService.houseRef.get().then((value) {
      listHouse = value.docs.map((e) => e.data()).toList();
    });
    return listHouse;
  }
}
