import 'package:app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';

class UserLoginProvider extends ChangeNotifier {
  Future<bool> login(String phoneNumber, String password) async {
    String response = await UserRepo().logIn(phoneNumber);
    print(response);
    if (response == "") {
      return false;
    }
    if (password == response) {
      return true;
    }
    return false;
  }
}
