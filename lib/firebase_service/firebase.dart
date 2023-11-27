import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );

  static final favouriteRef = FirebaseFirestore.instance
      .collection('favourite')
      .withConverter<Favourite>(
        fromFirestore: (snapshot, _) => Favourite.fromMap(snapshot.data()!),
        toFirestore: (favourite, _) => favourite.toMap(),
      );
}
