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
  ) async {
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
        status: 'waiting'));
  }

  Future<void> acceptBooking(String bookingId) async {
    await FirebaseService.bookingRef
        .doc(bookingId)
        .update({'status': 'accept'});
  }

  Future<void> declineBooking(String bookingId) async {
    await FirebaseService.bookingRef
        .doc(bookingId)
        .update({'status': 'decline'});
  }

  Future<List<Booking>> fetchWaitingBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'waiting')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }

  Future<List<Booking>> fetchAcceptBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'accept')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }

  Future<List<Booking>> fetchDeclineBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'decline')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }

  Future<List<Booking>> fetchWaitingBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('landlordId', isEqualTo: landlordId)
        .where('status', isEqualTo: 'waiting')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }

  Future<List<Booking>> fetchAcceptBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('landlordId', isEqualTo: landlordId)
        .where('status', isEqualTo: 'accept')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }

  Future<List<Booking>> fetchDeclineBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await FirebaseService.bookingRef
        .where('landlordId', isEqualTo: landlordId)
        .where('status', isEqualTo: 'decline')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        listBooking = value.docs.map((e) => e.data()).toList();
      }
    });
    return listBooking;
  }
}
