import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<void> uploadImg(String userPhone, File file) async {
    String fileName = file.path.split("/").last;
    print(createdAt);

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/landlord/$userPhone/house/$fileName');

      await ref.putFile(file);

      String downloadURL = await ref.getDownloadURL();
      updateImg(downloadURL, userPhone);
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
          .update({'img': urlImg});
    });
  }

  void currentDate() {
    DateTime timeNow = DateTime.now();
    createdAt = timeNow.toString();
  }
}
