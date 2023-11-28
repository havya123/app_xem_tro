import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
  static final houseRef =
      FirebaseFirestore.instance.collection('house').withConverter<House>(
            fromFirestore: (snapshot, _) => House.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
  static final roomRef = FirebaseFirestore.instance
      .collection('room')
      .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap());
}
