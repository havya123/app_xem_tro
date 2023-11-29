import 'dart:io';

import 'package:app_xem_tro/repository/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProvider extends ChangeNotifier {
  XFile? image;

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

  Future<void> changeName(String phoneNumber, String newName) async {
    await UserRepo().updateName(phoneNumber, newName);
  }

  Future<void> addPhone(String phoneNumber, String newPhone) async {
    await UserRepo().addNewPhone(phoneNumber, newPhone);
  }

  Future<void> changeEmail(String phoneNumber, String newEmail) async {
    await UserRepo().updateEmail(phoneNumber, newEmail);
  }

  Future<void> switchRole(String phoneNumber) async {
    await UserRepo().switchRole(phoneNumber);
  }

  Future<void> pickImageAvatarFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    image = returnImage;
    notifyListeners();
  }

  Future<void> pickImageAvatarFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      return Future.error("Storage permission is denied");
    }
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    image = returnImage;
    notifyListeners();
  }

  Future<void> updateImage(String userPhone) async {
    await UserRepo().uploadImg(userPhone, File(image!.path));
  }
}
