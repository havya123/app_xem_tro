import 'dart:async';

import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/repository/favourite_repository.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Favourite> listFavourite = [];
  List<String> favourieId = [];
  List<Room> listRoom = [];
  bool loadFavoutire = false;

  Future<void> addFavouriteItem(
      String houseId, String userId, String roomId, String houseAddress) async {
    if (favourieId.contains(roomId)) {
      favourieId.remove(roomId);
      await saveListId(houseId, userId, roomId, houseAddress);
      notifyListeners();
    } else {
      favourieId.add(roomId);
      await saveListId(houseId, userId, roomId, houseAddress);
      notifyListeners();
    }
  }

  bool isSaved(String id) {
    return favourieId.contains(id) ? true : false;
  }

  Future<void> saveListId(
      String houseId, String userId, String roomId, String houseAddress) async {
    bool isExist = await FavouriteRepo().checkExist(userId, roomId);
    if (isExist == false) {
      return;
    }
    await FavouriteRepo().saveWatchList(houseId, userId, roomId, houseAddress);
    await loadListId(userId);
  }

  Future<void> loadListId(String phone) async {
    List<Favourite> listWatchList =
        await FavouriteRepo().getFavouriteList(phone);
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
    if (favourieId.isNotEmpty) {
      for (var id in favourieId) {
        Room room = await RoomRegisterProvider().getRoomDetail(id);
        if (!listRoom.contains(room)) {
          listRoom.add(room);
        }
      }
    }
    loadFavoutire = true;
    notifyListeners();
  }
}
