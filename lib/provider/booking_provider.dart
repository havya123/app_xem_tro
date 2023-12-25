import 'package:app_xem_tro/config/widget/room_item.dart';
import 'package:app_xem_tro/models/booking.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/repository/booking_repository.dart';
import 'package:app_xem_tro/repository/room_repository.dart';
import 'package:flutter/foundation.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> listBookingUser = [];
  List<Booking> listBookingLandlord = [];
  List<Room> listRoom = [];

  List<String> listRoomId = [];

  Future<bool> saveBooking(
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
    if (await BookingRepo().checkIsExist(userPhone, roomId)) {
      return true;
    }
    await BookingRepo().saveBooking(
      userName,
      userPhone,
      userId,
      landlordName,
      landlordPhone,
      landlordId,
      roomId,
      date,
      time,
      address,
    );
    return false;
  }

  Future<void> acceptBooking(
      String userId, String landlordId, String roomId, String createdAt) async {
    await BookingRepo().acceptBooking(userId, landlordId, roomId, createdAt);
  }

  Future<void> declineBooking(
      String userId, String landlordId, String roomId, String createdAt) async {
    await BookingRepo().declineBooking(userId, landlordId, roomId, createdAt);
  }

  Future<void> getListBookingUser(String userId) async {
    listBookingUser = await BookingRepo().listBookingUser(userId);
    listRoomId = listBookingUser.map((e) => e.roomId).toList();
    await getListRoom();
    notifyListeners();
  }

  Future<void> getListBookingLandlord(String landlordId) async {
    listBookingLandlord = await BookingRepo().listBookingLandlord(landlordId);
    listRoomId = listBookingLandlord.map((e) => e.roomId).toList();
    await getListRoom();
    notifyListeners();
  }

  Future<void> getListRoom() async {
    for (var roomId in listRoomId) {
      await RoomRepo().roomDetail(roomId).then((value) {
        listRoom.add(value as Room);
      });
    }
    notifyListeners();
  }
}
