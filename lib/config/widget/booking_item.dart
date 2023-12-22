import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/models/booking.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/screen/booking_screen/booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class BookingItem extends StatelessWidget {
  BookingItem(
      {required this.role,
      required this.room,
      required this.booking,
      super.key});

  Room room;
  Booking booking;
  int role;
  @override
  Widget build(BuildContext context) {
    List<String> listImage = room.img!.split(',');
    return Material(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                BookingDetailWidget(room: room, booking: booking, role: role),
          );
        },
        child: Ink(
          child: Container(
              height: getHeight(context, height: 0.2),
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(
                  borderRadius(context),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: FadeInImage.memoryNetwork(
                          width: double.infinity,
                          height: getHeight(context, height: 0.16),
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: listImage[0],
                          imageErrorBuilder: (BuildContext context,
                              Object exception, StackTrace? stackTrace) {
                            return Image.network(
                                "https://icons.veryicon.com/png/o/education-technology/alibaba-cloud-iot-business-department/image-load-failed.png");
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              room.roomId,
                              style: mediumTextStyle(context, size: 0.03),
                            ),
                            spaceHeight(context, height: 0.01),
                            Row(
                              children: [
                                const Text('Lịch hẹn: '),
                                Text(
                                  "${booking.date} ",
                                  style: mediumTextStyle(context,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            spaceHeight(context),
                            Container(
                                height: getHeight(context, height: 0.04),
                                width: getWidth(context, width: 0.2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: booking.status == "accept"
                                        ? Colors.green
                                        : booking.status == "waiting"
                                            ? Colors.yellow
                                            : Colors.red),
                                child: Center(
                                  child: Text(
                                    booking.status,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ],
                        ),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
