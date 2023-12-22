import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:transparent_image/transparent_image.dart';

class HouseItem extends StatelessWidget {
  HouseItem({required this.houseId, required this.house, super.key});
  House house;
  String houseId;

  @override
  Widget build(BuildContext context) {
    List<String> listImage = house.img!.split(',');
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.overviewRote,
            arguments: {'house': house, 'houseId': houseId});
      },
      child: Container(
        width: getWidth(context, width: 0.8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(
            borderRadius(context),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: getHeight(context, height: 0.25),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FadeInImage.memoryNetwork(
                  width: double.infinity,
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
              SizedBox(
                height: getHeight(context, height: 0.2),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding(context, padding: 0.02),
                      vertical: padding(context, padding: 0.01)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        house.houseName,
                        style: largeTextStyle(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                      spaceHeight(context, height: 0.02),
                      Text(
                        "${house.street}, ${house.ward}, ${house.district}",
                        style: mediumTextStyle(context, color: Colors.grey),
                      ),
                      spaceHeight(context, height: 0.01),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
