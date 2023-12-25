import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/models/booking.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/screen/navigationlisthouse_screen/navigationlisthouse.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BookingDetailWidget extends StatelessWidget {
  BookingDetailWidget(
      {required this.role,
      required this.booking,
      required this.room,
      super.key});

  Room room;
  Booking booking;
  int role;
  @override
  Widget build(BuildContext context) {
    List<String> listImage = room.img!.split(", ");
    Color statusColors;
    bool cancel = false;
    if (booking.status == "waiting") {
      statusColors = Colors.yellow.shade400;
      cancel = true;
    } else if (booking.status == "accept") {
      statusColors = Colors.green;
    } else {
      statusColors = Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FractionallySizedBox(
        heightFactor: getHeight(context, height: 0.0025),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Divider(
                      endIndent: 150,
                      indent: 150,
                      thickness: 4,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  spaceHeight(context),
                  Text(
                    'Lịch hẹn',
                    style: largeTextStyle(context, color: Colors.grey.shade400),
                  ),
                  spaceHeight(context),
                  Container(
                      width: getWidth(context, width: 0.7),
                      height: getHeight(context, height: 0.2),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: listImage[0])),
                  spaceHeight(context),
                  listTitle(context, 'Tên người đặt: ', booking.userName,
                      Colors.grey.shade400, Colors.black),
                  spaceHeight(context),
                  listTitle(context, 'Số điện thoại: ', booking.userPhone,
                      Colors.grey.shade400, Colors.black),
                  spaceHeight(context),
                  listTitle(context, 'Tên chủ trọ: ', booking.landlordName,
                      Colors.grey.shade400, Colors.black),
                  spaceHeight(context),
                  listTitle(
                      context,
                      'Số điện thoại chủ trọ: ',
                      booking.landlordPhone,
                      Colors.grey.shade400,
                      Colors.black),
                  spaceHeight(context),
                  listTitle(context, 'Ngày hẹn: ', booking.date,
                      Colors.grey.shade400, Colors.black),
                  spaceHeight(context),
                  listTitle(context, 'Giờ hẹn: ', booking.time,
                      Colors.grey.shade400, Colors.black),
                  spaceHeight(context),
                  listTitle(context, 'Trạng thái: ', booking.status,
                      Colors.grey.shade400, statusColors),
                  spaceHeight(context),
                  booking.status != "waiting"
                      ? const SizedBox()
                      : role == 0
                          ? const SizedBox()
                          : ButtonWidget(
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Xác nhận lịch hẹn'),
                                      content: const SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: Text(
                                            'Xác nhận lịch hẹn',
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<BookingProvider>()
                                                  .acceptBooking(
                                                      booking.userId,
                                                      booking.landlordId,
                                                      booking.roomId,
                                                      booking.createdAt)
                                                  .then((value) async {
                                                await context
                                                    .read<BookingProvider>()
                                                    .getListBookingUser(
                                                        booking.userId)
                                                    .then((value) async {
                                                  await context
                                                      .read<BookingProvider>()
                                                      .getListBookingLandlord(
                                                          context
                                                              .read<
                                                                  UserLoginProvider>()
                                                              .userPhone)
                                                      .then((value) async {
                                                    await context
                                                        .read<BookingProvider>()
                                                        .getListRoom();
                                                  }).then((value) {
                                                    Get.back();
                                                    Get.back();
                                                  });
                                                });
                                              });
                                            },
                                            child: const Text(
                                                'Xác nhận lịch hẹn')),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Trở về')),
                                      ],
                                    );
                                  },
                                );
                              },
                              textButton: 'Xác nhận lịch hẹn',
                              listColor: const [Colors.white, Colors.white],
                              textColor: Colors.green,
                              border: true,
                              colorBorder: Colors.green,
                            ),
                  spaceHeight(context),
                  cancel
                      ? ButtonWidget(
                          function: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Xác nhận hủy'),
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 50,
                                            child: Image.asset(
                                              'assets/icons/alert.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        spaceHeight(context),
                                        const Text(
                                          'Bạn có chắc chắn về việc hủy lịch hẹn?',
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          context
                                              .read<BookingProvider>()
                                              .declineBooking(
                                                  booking.userId,
                                                  booking.landlordId,
                                                  booking.roomId,
                                                  booking.createdAt)
                                              .then((value) async {
                                            await context
                                                .read<BookingProvider>()
                                                .getListBookingUser(
                                                    booking.userId)
                                                .then((value) async {
                                              await context
                                                  .read<BookingProvider>()
                                                  .getListBookingLandlord(context
                                                      .read<UserLoginProvider>()
                                                      .userPhone)
                                                  .then((value) async {
                                                await context
                                                    .read<BookingProvider>()
                                                    .getListRoom();
                                              }).then((value) {
                                                Get.back();
                                              });
                                            });
                                          });
                                        },
                                        child: const Text('Xác nhận hủy')),
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Trở về')),
                                  ],
                                );
                              },
                            );
                          },
                          textButton: 'Hủy lịch hẹn',
                          listColor: const [Colors.white, Colors.white],
                          textColor: Colors.red,
                          border: true,
                        )
                      : const SizedBox(),
                  spaceHeight(context, height: 0.4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row listTitle(
    context,
    String title,
    String content,
    Color colorTitle,
    Color colorContent,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: smallMediumTextStyle(context, color: colorTitle, size: 0.023),
        ),
        Text(
          content,
          style: mediumTextStyle(context, color: colorContent, size: 0.028),
        ),
      ],
    );
  }
}
