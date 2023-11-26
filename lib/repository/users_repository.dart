import 'dart:ffi';

import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepo {
  void signUp(
    String phoneNumber,
    String password,
    String name,
    String email,
    String dob,
    String address,
  ) {
    FirebaseService.userRef.doc(phoneNumber).set(User(
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        dob: dob,
        email: email,
        address: address,
        avatar: "",
        token: "",
        role: 0));
  }

  Future<String> logIn(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["password"] ?? "";
  }

  Future<String> checkIfPhoneNumberExists(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response?["phoneNumber"] ?? "";
  }

  Future<void> changePass(String phoneNumber, String newPass) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .update({'password': newPass});
  }

  Future<void> setToken(String phoneNumber, String token) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .update({'token': token});
  }

  Future<String> getToken(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response!['token'] ?? "";
  }

  Future<int> checkRole(String phoneNumber) async {
    Map<String, dynamic>? response = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get()
        .then((value) => value.data());
    return response!['role'] ?? 0;
  }
}
