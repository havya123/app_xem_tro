import 'dart:async';

import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/repository/search_repository.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  StreamController<Map> searchController = StreamController<Map>.broadcast();
  Timer? timer;
  List listData = [];

  Future<void> searchList(
      String street, String ward, String district, String province) async {
    timer?.cancel();

    timer = Timer(const Duration(seconds: 1), () async {
      searchController.add({'status': statusCode.loading, 'data': []});
      var repo = await SearchRepository()
          .searchHouse(street, ward, district, province);
      if (repo.isEmpty) {
        listData.clear();
        searchController.add({'status': statusCode.success, 'data': listData});
      } else {
        listData.clear();
        listData = repo;
        searchController.add({'status': statusCode.success, 'data': listData});
      }
    });
  }

  @override
  void dispose() {
    searchController.close();
    super.dispose();
  }
}
