import 'dart:io';
import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepo {
  void signUp(String phoneNumber, String password, String name, String email,
      String dob, String address, String gender) {
    String createdAt = DateTime.now().toString();
    FirebaseService.userRef.doc(phoneNumber).set(User(
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        dob: dob,
        email: email,
        address: address,
        avatar:
            "https://firebasestorage.googleapis.com/v0/b/xemtro.appspot.com/o/images%2Fusers%2Fuser.png?alt=media&token=ba7315f5-74e4-4303-98aa-0f329e95aa9d",
        token: "",
        role: 0,
        createdAt: createdAt,
        gender: gender));
  }

  Future<String> logIn(String phoneNumber) async {
    User? response = await FirebaseService.userRef
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    if (response == null) {
      return "";
    }
    return response.password;
  }

  Future<User?> getUser(String userPhone) async {
    User? user =
        await FirebaseService.userRef.doc(userPhone).get().then((value) {
      return value.data();
    });
    return user;
  }

  Future<String> checkIfPhoneNumberExists(String phoneNumber) async {
    User? response = await FirebaseService.userRef
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    if (response == null) {
      return "";
    }
    return response.phoneNumber;
  }

  Future<void> changePass(String phoneNumber, String newPass) async {
    await FirebaseService.userRef
        .doc(phoneNumber)
        .update({'password': newPass});
  }

  Future<void> uploadImg(String userPhone, File file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('images/users/$userPhone.png');

      await ref.putFile(file);

      String downloadURL = await ref.getDownloadURL();
      await updateImg(downloadURL, userPhone);
    } catch (e) {}
  }

  Future<void> updateImg(String urlImg, String userPhone) async {
    await FirebaseService.userRef.doc(userPhone).update({'avatar': urlImg});
  }

  Future<void> updateName(String phoneNumber, String newName) async {
    await FirebaseService.userRef.doc(phoneNumber).update({'name': newName});
  }

  Future<void> updateAddress(String phoneNumber, String newAddress) async {
    await FirebaseService.userRef
        .doc(phoneNumber)
        .update({'address': newAddress});
  }

  Future<void> updateEmail(String phoneNumber, String newEmail) async {
    await FirebaseService.userRef.doc(phoneNumber).update({'email': newEmail});
  }

  Future<void> addNewPhone(String phoneNumber, String newPhone) async {
    User? response =
        await FirebaseService.userRef.doc(phoneNumber).get().then((value) {
      return value.data();
    });
    String phone = response!.phoneNumber;
    String addPhone = "$phone, $newPhone";
    await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .update({'phoneNumber': addPhone});
  }

  Future<void> switchRole(String phoneNumer) async {
    await FirebaseService.userRef.doc(phoneNumer).update({'role': 1});
  }

  Future<void> setToken(String phoneNumber, String token) async {
    await FirebaseService.userRef.doc(phoneNumber).update({'token': token});
  }

  Future<String> getToken(String phoneNumber) async {
    User? response = await FirebaseService.userRef
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response!.token;
  }

  Future<int> checkRole(String phoneNumber) async {
    User? response = await FirebaseService.userRef
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response!.role;
  }
}
