import 'package:app_xem_tro/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
}
