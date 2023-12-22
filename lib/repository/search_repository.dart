import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/house.dart';

class SearchRepository {
  Future<List> searchHouse(
    String street,
    String ward,
    String district,
    String province,
  ) async {
    List<House> listHouse = [];
    Set<String> uniqueDocIds = <String>{};
    List<String> listDoc = [];

    try {
      if (province.isNotEmpty) {
        await FirebaseService.houseRef
            .where('province', isEqualTo: province)
            .where('status', isEqualTo: 'accept')
            .get()
            .then((value) {
          uniqueDocIds.addAll(value.docs.map((e) => e.id));
        });
      }
      if (district.isNotEmpty) {
        uniqueDocIds.clear();
        await FirebaseService.houseRef
            .where('province', isEqualTo: province)
            .where('district', isEqualTo: district)
            .where('status', isEqualTo: 'accept')
            .get()
            .then((value) {
          uniqueDocIds.addAll(value.docs.map((e) => e.id));
        });
      }

      if (ward.isNotEmpty) {
        uniqueDocIds.clear();
        await FirebaseService.houseRef
            .where('ward', isEqualTo: ward)
            .where('province', isEqualTo: province)
            .where('district', isEqualTo: district)
            .where('status', isEqualTo: 'accept')
            .get()
            .then((value) {
          uniqueDocIds.clear();
          uniqueDocIds.addAll(value.docs.map((e) => e.id));
        });
      }

      if (street.isNotEmpty) {
        await FirebaseService.houseRef
            .where('street', isEqualTo: street)
            .where('status', isEqualTo: 'accept')
            .get()
            .then((value) {
          uniqueDocIds.addAll(value.docs.map((e) => e.id));
        });
      }

      listDoc = uniqueDocIds.toList();
      for (String docId in listDoc) {
        await FirebaseService.houseRef.doc(docId).get().then((value) {
          if (value.exists) {
            listHouse.add(value.data() as House);
          } else {}
        });
      }
      if (listHouse.isNotEmpty) {
        List listData = [
          listHouse,
          listDoc,
        ];
        return listData;
      }
      await FirebaseService.houseRef.get().then((value) {
        listHouse = value.docs.map((e) => e.data()).toList();
      });
      List listData = [
        listHouse,
        listDoc,
      ];
      return listData;
    } catch (e) {
      return [];
    }
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
