import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> uploadImg(
      String userPhone, List<XFile?> listXFile, String houseId) async {
    List<String> fileName =
        listXFile.map((e) => e!.path.split("/").last).toList();

    try {
      for (int i = 0; i < listXFile.length; i++) {
        Reference ref = FirebaseStorage.instance.ref().child(
            'images/landlord/$userPhone/house/room/$houseId/${fileName[i]}');

        await ref.putFile(File(listXFile[i]!.path));

        String downloadURL = await ref.getDownloadURL();
        updateImg(downloadURL, houseId);
      }
    } catch (e) {}
  }

  Future<void> updateImg(
    String urlImg,
    String houseId,
  ) async {
    await FirebaseFirestore.instance
        .collection('room')
        .where('houseId', isEqualTo: houseId)
        .where('createAt', isEqualTo: createAt)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('room')
          .doc(value.docs.first.id)
          .get()
          .then((value1) async {
        Map<String, dynamic>? response = value1.data();
        String currentImage = response?['img'] ?? "";
        String addImg = "";
        if (currentImage == "") {
          addImg = urlImg;
        } else {
          addImg = "$currentImage, $urlImg";
        }
        FirebaseFirestore.instance
            .collection('room')
            .doc(value.docs.first.id)
            .update({'img': addImg});
      });
    });
  }

  Future<List<Room>> getListRoom(String houseId) async {
    List<Room> listRoom = [];
    await FirebaseFirestore.instance
        .collection('room')
        .where('housId', isEqualTo: houseId)
        .get()
        .then((value) {
      listRoom = value.docs.map((e) => Room.fromMap(e.data())).toList();
    });
    return listRoom;
  }
}
