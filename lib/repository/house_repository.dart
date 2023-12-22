import 'dart:io';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HouseRepo {
  static String createdAt = "";
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
    currentDate();
    String fullAddress = "$street, $ward, $district, $province";
    FirebaseService.houseRef.doc().set(House(
        userName: userName,
        phoneNumber: phoneNumber,
        houseName: houseName,
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
        userPhone: userPhone,
        status: 'waiting',
        fullAddress: fullAddress));
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

  Future<House> getHouseDetail(String houseId) async {
    House house =
        await FirebaseService.houseRef.doc(houseId).get().then((value) {
      return value.data() as House;
    });
    return house;
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

  Future<List> getListHouse(String userPhone) async {
    List<House> listHouse = [];
    List<String> listDoc = [];
    List listDocHouse = [];
    await FirebaseFirestore.instance
        .collection('house')
        .where('userPhone', isEqualTo: userPhone)
        .get()
        .then((value) {
      listDoc = value.docs.map((e) => e.id).toList();
      listDocHouse.add(listDoc);
      listHouse = value.docs.map((e) => House.fromMap(e.data())).toList();
      listDocHouse.add(listHouse);
    });
    return listDocHouse;
  }

  Future<List> getListHouseNearBy(String address) async {
    String address =
        "69/1/25 Nguyễn Gia Trí, Phường 25, Quận Bình Thạnh, Thành Phố Hồ Chí Minh";
    List<House> listHouse = [];
    List<String> listAddress = address.split(', ').toList();
    Set<String> uniqueDocIds = <String>{};
    List<String> listDoc = [];

    if (address.isEmpty) {
      await FirebaseService.houseRef.get().then((value) {
        listHouse = value.docs.map((e) => e.data()).toList().take(5).toList();
        uniqueDocIds.addAll(value.docs.map((e) => e.id));
      });
      List listData = [
        listHouse,
        listDoc,
      ];
      return listData;
    }
    await FirebaseService.houseRef
        .where('street', isEqualTo: listAddress[0])
        .where('status', isEqualTo: 'accept')
        .get()
        .then((value) {
      uniqueDocIds.addAll(value.docs.map((e) => e.id));
    });

    await FirebaseService.houseRef
        .where('ward', isEqualTo: listAddress[1])
        .where('status', isEqualTo: 'accept')
        .get()
        .then((value) {
      uniqueDocIds.addAll(value.docs.map((e) => e.id));
    });
    await FirebaseService.houseRef
        .where('district', isEqualTo: listAddress[2])
        .where('status', isEqualTo: 'accept')
        .get()
        .then((value) {
      uniqueDocIds.addAll(value.docs.map((e) => e.id));
    });

    listDoc = uniqueDocIds.toList();
    for (String docId in listDoc) {
      await FirebaseService.houseRef.doc(docId).get().then((value) {
        if (value.exists) {
          listHouse.add(value.data() as House);
        } else {}
      });
    }
    if (listHouse.isNotEmpty) {
      List listData = [
        listHouse,
        listDoc,
      ];
      return listData;
    }
    await FirebaseService.houseRef.get().then((value) {
      listHouse = value.docs.map((e) => e.data()).toList();
    });
    List listData = [
      listHouse,
      listDoc,
    ];

    return listData;
  }

  Future<List> getAllHouse() async {
    List<String> listDoc = [];
    List<House> listHouse = [];
    await FirebaseService.houseRef
        .where('status', isEqualTo: 'accept')
        .where('province', isEqualTo: 'Thành phố Hồ Chí Minh')
        .get()
        .then((value) {
      listDoc = value.docs.map((e) => e.id).toList();
      listHouse = value.docs.map((e) => e.data()).toList();
    });
    List listData = [listDoc, listHouse];
    return listData;
  }
}
