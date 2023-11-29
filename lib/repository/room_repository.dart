import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RoomRepo {
  static String createAt = "";

  Future<void> roomRegistration(
      String houseId,
      String roomId,
      String utilities,
      String numberOfPeople,
      String numberOfFloor,
      String acreage,
      String? img,
      String price) async {
    currentDate();

    FirebaseService.roomRef.doc().set(Room(
        houseId: houseId,
        roomId: roomId,
        utilities: utilities,
        numberOfPeople: numberOfPeople,
        numberOfFloor: numberOfFloor,
        acreage: acreage,
        createAt: createAt,
        price: price));
  }

  void currentDate() {
    DateTime timeNow = DateTime.now();
    createAt = timeNow.toString();
  }

  Future<void> uploadImg(String userPhone, File file) async {
    String fileName = file.path.split("/").last;

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/landlord/$userPhone/room/$fileName');

      await ref.putFile(file);

      String downloadURL = await ref.getDownloadURL();
      updateImg(downloadURL, userPhone);
    } catch (e) {}
  }

  Future<void> updateImg(String urlImg, String userPhone) async {
    await FirebaseFirestore.instance
        .collection('room')
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('room')
          .doc(value.docs.first.id)
          .update({'img': urlImg});
    });
  }
}
