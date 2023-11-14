import 'dart:async';

import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/place.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:app_xem_tro/repository/google_map_repository.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends ChangeNotifier {
  List<Province> listProvince = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];

  LatLng latLng = const LatLng(10.775213008184023, 106.62146058976832);

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

  Future<void> searchPlace(String keyword, Function function) async {
    Place? place = await GoogleMapRepo().getPlace(keyword);
    if (place != null) {
      setMaker(LatLng(place.lat, place.lng));
    } else {
      function();
    }
  }

  Marker marker = const Marker(markerId: MarkerId("Marker1"));

  Future<void> setMaker(LatLng position) async {
    marker = Marker(
        markerId: const MarkerId("Marker1"),
        position: LatLng(position.latitude, position.longitude));
    latLng = position;
    notifyListeners();
  }

  Future<void> goToPlace(Completer<GoogleMapController> completer) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 24)));
  }
}
