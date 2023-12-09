import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class RoomItem extends StatelessWidget {
  RoomItem({this.roomId, required this.room, super.key});
  Room room;
  String? roomId;
  @override
  Widget build(BuildContext context) {
    List<String> listImage = room.img!.split(',');
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.detailRoute,
            arguments: {'room': room, 'roomId': roomId});
      },
      child: Container(
        height: getHeight(context, height: 0.3),
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
              child: FadeInImage.memoryNetwork(
                width: double.infinity,
                height: getHeight(context, height: 0.3),
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: listImage[0],
                imageErrorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.network(
                      "https://icons.veryicon.com/png/o/education-technology/alibaba-cloud-iot-business-department/image-load-failed.png");
                },
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding(context, padding: 0.02),
                      vertical: padding(context, padding: 0.01)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: getHeight(context, height: 0.04),
                            width: getWidth(context, width: 0.04),
                            child: const Image(
                              image:
                                  AssetImage("assets/images/home_img/star.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          spaceWidth(context, width: 0.02),
                          Text(
                            "4.8(73)",
                            style: smallTextStyle(context),
                          ),
                        ],
                      ),
                      Text(
                        room.roomId,
                        style: mediumTextStyle(context, size: 0.03),
                      ),
                      spaceHeight(context, height: 0.01),
                      Expanded(
                        child: Text(
                          "Cơ sở vật chất: ${room.utilities}",
                          style: mediumTextStyle(context),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
