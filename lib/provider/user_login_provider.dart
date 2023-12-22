import 'package:app_xem_tro/repository/users_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginProvider extends ChangeNotifier {
  String userPhone = "";

  Future<void> updatePhone(String phone) async {
    userPhone = phone;

    notifyListeners();
  }

  Future<bool> login(String phoneNumber, String password) async {
    String response = await UserRepo().logIn(phoneNumber);
    if (response == "") {
      return false;
    }
    if (password == response) {
      await updatePhone(phoneNumber);
      return true;
    }
    return false;
  }

  Future<void> saveToken(String phoneNumber) async {
    DateTime dateTime = DateTime.now();
    String token = dateTime.add(const Duration(days: 2)).toString();
    await UserRepo().setToken(phoneNumber, token);
  }

  Future<void> savePhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> readPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String phoneNumber = prefs.getString('phoneNumber') ?? "";
    userPhone = phoneNumber;
    notifyListeners();
  }

  Future<bool> checkTokenExpired() async {
    readPhoneNumber();
    DateTime currentDate = DateTime.now();
    String token = await UserRepo().getToken(userPhone);
    if (token == "") {
      return false;
    }
    DateTime token2 = DateTime.parse(token);
    if (currentDate.compareTo(token2) > 0 ||
        currentDate.compareTo(token2) == 0) {
      return false;
    }
    return true;
  }

  Future<int> checkRole() async {
    int role = await UserRepo().checkRole(userPhone);
    return role;
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    FirebaseAuth.instance.signOut();
    updatePhone("");
  }
}
