import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/favourite.dart';

class FavouriteRepo {
  void saveWatchList(String houseId, String userId) {
    FirebaseService.favouriteRef
        .doc()
        .set(Favourite(houseId: houseId, userId: userId));
  }

  Future<bool> checkExist(String phone, String houseId) async {
    final film = await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .where('houseId', isEqualTo: houseId)
        .get();
    if (film.docs.isEmpty) {
      return true;
    }
    film.docs.first.reference.delete();
    return false;
  }

  Future<List<Favourite>> getFavouriteList(String phone) async {
    List<Favourite> listFavourite = [];
    await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .get()
        .then((value) => value.docs.forEach((element) {
              listFavourite.add(element.data());
            }));
    return listFavourite;
  }

  Future<void> getHouseDetail(String id) async {}
}
