import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        price: price,
        bookingStatus: 'available'));
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

  Future<List> getListRoom(String houseId) async {
    List data = [];
    List<Room> listRoom = [];
    List<String> listIdRoom = [];
    await FirebaseFirestore.instance
        .collection('room')
        .where('houseId', isEqualTo: houseId)
        .where('bookingStatus', isEqualTo: 'available')
        .get()
        .then((value) {
      listIdRoom = value.docs.map((e) => e.id).toList();
      listRoom = value.docs.map((e) => Room.fromMap(e.data())).toList();
    });
    data = [listIdRoom, listRoom];
    return data;
  }

  Future<List> getListRoomLandlord(String houseId) async {
    List data = [];
    List<Room> listRoom = [];
    List<String> listIdRoom = [];
    await FirebaseFirestore.instance
        .collection('room')
        .where('houseId', isEqualTo: houseId)
        .get()
        .then((value) {
      listIdRoom = value.docs.map((e) => e.id).toList();
      listRoom = value.docs.map((e) => Room.fromMap(e.data())).toList();
    });
    data = [listIdRoom, listRoom];
    return data;
  }

  Future<User?> getUser(String houseId) async {
    House? house =
        await FirebaseService.houseRef.doc(houseId).get().then((value) {
      return value.data();
    });
    User? user =
        await FirebaseService.userRef.doc(house!.userPhone).get().then((value) {
      return value.data();
    });
    return user;
  }

  Future<Room?> roomDetail(String roomId) async {
    Room? room = await FirebaseService.roomRef.doc(roomId).get().then((value) {
      return value.data();
    });
    return room;
  }

  Future<void> bookedStatusRoom(String roomId) async {
    await FirebaseService.roomRef
        .doc(roomId)
        .update({'bookingStatus': 'booked'});
  }

  Future<void> availableStatusRoom(String roomId) async {
    await FirebaseService.roomRef
        .doc(roomId)
        .update({'bookingStatus': 'available'});
  }
}
