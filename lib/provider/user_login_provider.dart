import 'package:app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginProvider extends ChangeNotifier {
  String userPhone = "";

  Future<bool> login(String phoneNumber, String password) async {
    String response = await UserRepo().logIn(phoneNumber);
    if (response == "") {
      return false;
    }
    if (password == response) {
      return true;
    }
    return false;
  }

  Future<void> saveToken(String phoneNumber) async {
    DateTime dateTime = DateTime.now();
    String token = dateTime.add(const Duration(days: 2)).toString();
    await UserRepo().setToken(phoneNumber, token);
  }

  void savePhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> readPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String phoneNumber = prefs.getString('phoneNumber') ?? "";
    print(phoneNumber);
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
}
