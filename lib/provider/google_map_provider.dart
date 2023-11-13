import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:app_xem_tro/repository/google_map_repository.dart';
import 'package:flutter/material.dart';

class GoogleMapProvider extends ChangeNotifier {
  List<Province> listProvince = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];

  Future<void> getListProvince() async {
    listProvince = await GoogleMapRepo().getListProvince();
    notifyListeners();
  }

  Future<void> getListDistrict(int code) async {
    listDistrict = await GoogleMapRepo().getListDistrict(code);
    notifyListeners();
  }

  Future<void> getListWard(int code) async {
    listWard = await GoogleMapRepo().getListWard(code);
    notifyListeners();
  }
}
