import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  void signUp(String phoneNumber, String password, String name, String email,
      String dob, String address, String? avatar) {
    FirebaseService.userRef.doc(phoneNumber).set(User(
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        dob: dob,
        email: email,
        address: address,
        avatar: ""));
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
}
