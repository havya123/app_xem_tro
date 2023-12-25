import 'dart:async';

import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/repository/favourite_repository.dart';
import 'package:app_xem_tro/repository/room_repository.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Favourite> listFavourite = [];
  // List<String> favourieId = [];
  List<Room> listRoom = [];
  bool loadFavoutire = false;

  // Future<void> addFavouriteItem(String houseId, String userId, String roomId,
  //     String houseAddress) async {}

  // Future<void> addFavouriteItem(
  //     String houseId, String userId, String roomId, String houseAddress) async {
  //   if (favourieId.contains(roomId)) {
  //     favourieId.remove(roomId);
  //     await saveListId(houseId, userId, roomId, houseAddress);
  //     notifyListeners();
  //   } else {
  //     favourieId.add(roomId);
  //     await saveListId(houseId, userId, roomId, houseAddress);

  //     notifyListeners();
  //   }
  // }

  bool isSaved(String id) {
    for (var roomId in listFavourite) {
      if (roomId.roomId == id) {
        return true;
      }
    }
    return false;
  }

  Future<void> saveItem(
      String houseId, String userId, String roomId, String houseAddress) async {
    bool isExist = await FavouriteRepo().checkExist(userId, roomId);
    if (!isExist) {
      await FavouriteRepo()
          .saveWatchList(houseId, userId, roomId, houseAddress);
    } else {
      return;
    }
  }

  Future<void> loadWatchList(String userPhone) async {
    listFavourite = await FavouriteRepo().getFavouriteList(userPhone);
    await getListRoomFavoutire();
  }

  Future<void> getListRoomFavoutire() async {
    listRoom.clear();
    for (var roomId in listFavourite) {
      var response = await RoomRepo().roomDetail(roomId.roomId);
      if (response != null) {
        listRoom.add(response);
      }
    }
    loadFavoutire = true;
    notifyListeners();
  }

  // Future<void> saveListId(
  //     String houseId, String userId, String roomId, String houseAddress) async {
  //   bool isExist = await FavouriteRepo().checkExist(userId, roomId);
  //   if (isExist == false) {
  //     return;
  //   }
  //   await FavouriteRepo().saveWatchList(houseId, userId, roomId, houseAddress);
  //   await loadListId(userId);
  //   await loadWatchList();
  // }

  // Future<void> loadListId(String phone) async {
  //   List<Favourite> listWatchList =
  //       await FavouriteRepo().getFavouriteList(phone);
  //   if (listWatchList.isNotEmpty) {
  //     listFavourite = listWatchList;
  //     favourieId = listWatchList.map((e) => e.roomId).toList();
  //   } else {
  //     favourieId = [];
  //   }
  //   notifyListeners();
  // }

  // Future<void> loadWatchList() async {
  //   listRoom.clear();
  //   if (favourieId.isNotEmpty) {
  //     for (var id in favourieId) {
  //       print(id);
  //       Room room = await RoomRegisterProvider().getRoomDetail(id);
  //       print(room);
  //       if (!listRoom.contains(room)) {
  //         listRoom.add(room);
  //       }
  //     }
  //   }
  //   loadFavoutire = true;
  //   notifyListeners();
  // }
}
