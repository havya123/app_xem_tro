import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';

class SearchRepository {
  Future<List<House>> searchHouse() async {
    String address = 'Quận bình thạnh';
    List<House> listHouse = [];
    await FirebaseService.houseRef
        .where('fullAddress', arrayContains: address)
        .get()
        .then((value) {
      listHouse = value.docs.map((e) => e.data()).toList();
    });
    return listHouse;
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input
        .toLowerCase()
        .split(' ')
        .map((word) =>
            word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
