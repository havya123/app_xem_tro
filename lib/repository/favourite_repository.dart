import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/favourite.dart';

class FavouriteRepo {
  Future<void> saveWatchList(
      String houseId, String userId, String roomId, String houseAddress) async {
    await FirebaseService.favouriteRef.doc().set(Favourite(
        houseId: houseId,
        userId: userId,
        roomId: roomId,
        houseAddress: houseAddress));
  }

  Future<bool> checkExist(String phone, String roomId) async {
    final film = await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .where('roomId', isEqualTo: roomId)
        .get();
    if (film.docs.isEmpty) {
      return false;
    }
    film.docs.first.reference.delete();
    return true;
  }

  Future<List<Favourite>> getFavouriteList(String phone) async {
    List<Favourite> listFavourite = [];
    await FirebaseService.favouriteRef
        .where('userId', isEqualTo: phone)
        .get()
        .then((value) {
      listFavourite = value.docs.map((e) => e.data()).toList();
    });
    return listFavourite;
  }
}
