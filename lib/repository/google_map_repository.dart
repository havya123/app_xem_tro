import 'dart:convert';

import 'package:app_xem_tro/models/district.dart';
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

    print(data);

    List listData = data['wards'];

    List<Ward> listDistrict =
        List<Ward>.from(listData.map((e) => Ward.fromJson(jsonEncode(e))))
            .toList();

    return listDistrict;
  }

  // Future<List<Province>> getListProvince() async {
  //   String url = "https://provinces.open-api.vn/api/?depth=1";
  //   final uri = Uri.parse(url);

  //   var response = await http.get(uri);
  //   List data = jsonDecode(utf8.decode(response.bodyBytes));

  //   List<Province> listProvince =
  //       List<Province>.from(data.map((e) => Province.fromJson(jsonEncode(e))))
  //           .toList();

  //   return listProvince;
  // }
}
