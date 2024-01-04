import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/booking.dart';
import 'package:firebase_core/firebase_core.dart';

class BookingRepo {
  Future<void> saveBooking(
    String userName,
    String userPhone,
    String userId,
    String landlordName,
    String landlordPhone,
    String landlordId,
    String roomId,
    String date,
    String time,
    String address,
  ) async {
    DateTime currentTime = DateTime.now();
    String createdAt = currentTime.toString();

    await FirebaseService.bookingRef.doc().set(Booking(
        userId: userId,
        userName: userName,
        userPhone: userPhone,
        landlordId: landlordId,
        landlordName: landlordName,
        landlordPhone: landlordPhone,
        roomId: roomId,
        date: date,
        time: time,
        status: 'waiting',
        createdAt: createdAt,
        address: address));
  }

  Future<void> acceptBooking(
      String userId, String landlordId, String roomId, String createdAt) async {
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .where('landlordId', isEqualTo: landlordId)
        .where('roomId', isEqualTo: roomId)
        .where('createdAt', isEqualTo: createdAt)
        .get()
        .then((value) async {
      await FirebaseService.bookingRef
          .doc(value.docs.first.id)
          .update({'status': 'accept'});
    });
  }

  Future<void> declineBooking(
      String userId, String landlordId, String roomId, String createdAt) async {
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .where('landlordId', isEqualTo: landlordId)
        .where('roomId', isEqualTo: roomId)
        .where('createdAt', isEqualTo: createdAt)
        .get()
        .then((value) async {
      await FirebaseService.bookingRef
          .doc(value.docs.first.id)
          .update({'status': 'decline'});
    });
  }

  Future<List<Booking>> listBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();

        listBooking.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });
    return listBooking;
  }

  Future<List<Booking>> listBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('landlordId', isEqualTo: landlordId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
        listBooking.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });

    return listBooking;
  }

  Future<bool> checkIsExist(String userPhone, String roomId) async {
    var response = await FirebaseService.bookingRef
        .where('userPhone', isEqualTo: userPhone)
        .where('roomId', isEqualTo: roomId)
        .where('status', isEqualTo: 'accept')
        .get();

    if (response.docs.isNotEmpty) {
      var createdAt = DateTime.parse(response.docs.first.data().createdAt)
          .add(const Duration(days: 7));
      var currentTime = DateTime.now();

      if (currentTime.isBefore(createdAt)) {
        return true;
      }
      return false;
    }

    var response2 = await FirebaseService.bookingRef
        .where('userPhone', isEqualTo: userPhone)
        .where('roomId', isEqualTo: roomId)
        .where('status', isEqualTo: 'waiting')
        .get();

    if (response.docs.isEmpty && response2.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
