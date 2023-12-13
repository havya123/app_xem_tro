import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/favourite.dart';

class FavouriteRepo {
  Future<void> saveWatchList(
      String houseId, String userId, String roomId) async {
    await FirebaseService.favouriteRef
        .doc()
        .set(Favourite(houseId: houseId, userId: userId, roomId: roomId));
  }

  Future<bool> checkExist(String phone, String roomId) async {
    final film = await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .where('roomId', isEqualTo: roomId)
        .get();
    if (film.docs.isEmpty) {
      return true;
    }
    film.docs.first.reference.delete();
    return false;
  }

  Future<List<Favourite>> getFavouriteList(String phone) async {
    print(phone);
    List<Favourite> listFavourite = [];
    await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .get()
        .then((value) {
      listFavourite = value.docs.map((e) => e.data()).toList();
    });
    print(listFavourite);
    return listFavourite;
  }
}
