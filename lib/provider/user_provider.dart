import 'package:app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  void signUp(String phoneNumber, String password, String name, String email,
      String dob, String address) {
    UserRepo().signUp(phoneNumber, password, name, email, dob, address);
  }

  Future<bool> checkingNumberPhone(String phoneNumber) async {
    String response = await UserRepo().checkIfPhoneNumberExists(phoneNumber);
    if (phoneNumber == response) {
      return false;
    }
    return true;
  }

  Future<void> changeNewPass(String phoneNumber, String newPass) async {
    await UserRepo().changePass(phoneNumber, newPass);
  }
}
