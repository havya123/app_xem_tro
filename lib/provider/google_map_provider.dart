import 'dart:async';

import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/place.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:app_xem_tro/repository/google_map_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends ChangeNotifier {
  List<Province> listProvince = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];

  LatLng? currentPosition;
  String currentPlace = "";

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

  Future<void> initPlace() async {
    await getCurrentPosition();
    Place? place = await GoogleMapRepo().getPlaceByAttitude(
        "${currentPosition!.latitude},${currentPosition!.longitude}");
    if (place != null) {
      currentPlace = place.address;
      notifyListeners();
    } else {
      currentPlace;
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

  Future<void> getCurrentPosition() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied ");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied,we can not request permission');
    }
    var position = await Geolocator.getCurrentPosition();
    currentPosition = LatLng(position.latitude, position.longitude);
  }
}
