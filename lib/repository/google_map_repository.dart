import 'dart:convert';

import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/place.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:http/http.dart' as http;

class GoogleMapRepo {
  Future<List<Province>> getListProvince() async {
    String url = "https://provinces.open-api.vn/api/?depth=1";
    final uri = Uri.parse(url);

    var response = await http.get(uri);
    List data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Province> listProvince =
        List<Province>.from(data.map((e) => Province.fromJson(jsonEncode(e))))
            .toList();

    return listProvince;
  }

  Future<List<District>> getListDistrict(int code) async {
    String url = "https://provinces.open-api.vn/api/p/$code?depth=2";
    final uri = Uri.parse(url);

    var response = await http.get(uri);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List listData = data['districts'];

    List<District> listDistrict = List<District>.from(
        listData.map((e) => District.fromJson(jsonEncode(e)))).toList();

    return listDistrict;
  }

  Future<List<Ward>> getListWard(int code) async {
    String url = "https://provinces.open-api.vn/api/d/$code?depth=2";
    final uri = Uri.parse(url);

    var response = await http.get(uri);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List listData = data['wards'];

    List<Ward> listDistrict =
        List<Ward>.from(listData.map((e) => Ward.fromJson(jsonEncode(e))))
            .toList();

    return listDistrict;
  }

  Future<Place?> getPlace(String keyword) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?v=3.exp&key=AIzaSyDEFaondohAb1N-2wvpqU4Qn_T17ST1kSg&language=vi&region=VN&query=$keyword";

    final uri = Uri.parse(url);

    var response = await http.get(uri);
    Map<String, dynamic> data = jsonDecode(response.body);
    List location = data['results'];
    if (location.isEmpty) {
      return null;
    }
    Map<String, dynamic> dataLocation = location[0];
    Place place = Place(
        name: dataLocation['name'],
        address: dataLocation['formatted_address'],
        lat: dataLocation['geometry']['location']['lat'],
        lng: dataLocation['geometry']['location']['lng']);

    return place;
  }

  Future<Place?> getPlaceByAttitude(String keyword) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$keyword&key=AIzaSyDEFaondohAb1N-2wvpqU4Qn_T17ST1kSg";

    final uri = Uri.parse(url);
    var response = await http.get(uri);
    Map<String, dynamic> data = jsonDecode(response.body);
    List location = data['results'];
    if (location.isEmpty) {
      return null;
    }
    Map<String, dynamic> dataLocation = location[0];
    Place place = Place(
        name: "",
        address: dataLocation['formatted_address'],
        lat: dataLocation['geometry']['location']['lat'],
        lng: dataLocation['geometry']['location']['lng']);

    return place;
  }
}
