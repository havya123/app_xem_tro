import 'package:app_xem_tro/models/booking.dart';
import 'package:app_xem_tro/repository/booking_repository.dart';
import 'package:flutter/foundation.dart';

class BookingProvider extends ChangeNotifier {
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
    await BookingRepo().saveBooking(userName, userPhone, userId, landlordName,
        landlordPhone, landlordId, roomId, date, time);
  }

  Future<void> acceptBooking(String bookingId) async {
    await BookingRepo().acceptBooking(bookingId);
  }

  Future<void> declineBooking(String bookingId) async {
    await BookingRepo().declineBooking(bookingId);
  }

  Future<List<Booking>> fetchWaitingBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchWaitingBookingUser(userId)
        .then((value) => listBooking = value);
    return listBooking;
  }

  Future<List<Booking>> fetchAcceptBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchAcceptBookingUser(userId)
        .then((value) => listBooking = value);
    return listBooking;
  }

  Future<List<Booking>> fetchDeclineBookingUser(String userId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchDeclineBookingUser(userId)
        .then((value) => listBooking = value);
    return listBooking;
  }

  Future<List<Booking>> fetchWaitingBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchAcceptBookingLandlord(landlordId)
        .then((value) => listBooking = value);
    return listBooking;
  }

  Future<List<Booking>> fetchAcceptBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchAcceptBookingLandlord(landlordId)
        .then((value) => listBooking = value);
    return listBooking;
  }

  Future<List<Booking>> fetchDeclineBookingLandlord(String landlordId) async {
    List<Booking> listBooking = [];
    await BookingRepo()
        .fetchDeclineBookingLandlord(landlordId)
        .then((value) => listBooking = value);
    return listBooking;
  }
}
