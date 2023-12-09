import 'dart:async';

import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/repository/favourite_repository.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Favourite> listFavourite = [];
  List<String> favourieId = [];
  List<Room> listRoom = [];
  StreamController<Map<String, dynamic>> favouriteController =
      StreamController<Map<String, dynamic>>.broadcast();

  void addFavouriteItem(String houseId, String userId, String roomId) async {
    if (favourieId.contains(roomId)) {
      favourieId.remove(roomId);
      saveListId(houseId, userId, roomId);
      notifyListeners();
    } else {
      favourieId.add(roomId);
      saveListId(houseId, userId, roomId);
      notifyListeners();
    }
  }

  bool isSaved(String id) {
    print(favourieId);
    return favourieId.contains(id) ? true : false;
  }

  void saveListId(String houseId, String userId, String roomId) async {
    bool isExist = await FavouriteRepo().checkExist(userId, roomId);
    if (isExist == false) {
      return;
    }
    FavouriteRepo().saveWatchList(houseId, userId, roomId);
  }

  Future<void> loadListId(String phone) async {
    List<Favourite> listWatchList =
        await FavouriteRepo().getFavouriteList(phone);
    print(listWatchList);
    if (listWatchList.isNotEmpty) {
      listFavourite = listWatchList;
      favourieId = listWatchList.map((e) => e.roomId).toList();
    } else {
      favourieId = [];
    }
    notifyListeners();
  }

  Future<void> loadWatchList() async {
    listRoom.clear();
    favouriteController.add({'status': statusCode.loading, 'data': listRoom});
    if (favourieId.isNotEmpty) {
      for (var id in favourieId) {
        Room room = await RoomRegisterProvider().getRoomDetail(id);
        if (!listRoom.contains(room)) {
          listRoom.add(room);
        }
      }
      favouriteController.add({'status': statusCode.success, 'data': listRoom});
    }

    notifyListeners();
  }

  @override
  void dispose() {
    favouriteController.close();
    super.dispose();
  }
}
