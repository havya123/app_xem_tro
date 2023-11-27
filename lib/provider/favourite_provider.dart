import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/repository/favourite_repository.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> favourieId = [];
  List<Favourite> favourite = [];
  bool isSaved(String id) {
    return favourieId.contains(id) ? true : false;
  }

  void addFavouriteItem(String userPhone, String id) async {
    if (favourieId.contains(id)) {
      favourieId.remove(id);
      saveListId(userPhone, id);
      notifyListeners();
    } else {
      favourieId.add(id);
      saveListId(userPhone, id);
      notifyListeners();
    }
  }

  void saveListId(String userPhone, String id) async {
    bool isExist = await FavouriteRepo().checkExist(userPhone, id);
    if (isExist == false) {
      return;
    }
    FavouriteRepo().saveWatchList(userPhone, id);
  }

  Future<void> loadListId(String phone) async {
    List<Favourite> listWatchList =
        await FavouriteRepo().getFavouriteList(phone);
    if (listWatchList.isNotEmpty) {
      favourieId = listWatchList.map((e) => e.houseId).toList();
    } else {
      favourieId = [];
    }
    notifyListeners();
  }

  // Future<void> loadFavouriteList() async {
  //   favourite.clear();
  //   if (favourieId.isNotEmpty) {
  //     for (var id in favourieId) {
  //       Favourite? movie = await FavouriteRepo().getHouseDetail(id);
  //       if (movie != null && !movies.contains(movie)) {
  //         movies.add(movie);
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }
}
