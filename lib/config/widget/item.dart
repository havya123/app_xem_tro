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
        height: getHeight(context, height: 0.3),
        width: getWidth(context, width: 0.9),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: getHeight(context, height: 0.06),
                            child: Row(
                              children: [
                                const Image(
                                  image: AssetImage(
                                      "assets/images/home_img/star.png"),
                                  fit: BoxFit.contain,
                                ),
                                spaceWidth(context),
                                Text(
                                  "4.8(73)",
                                  style: mediumTextStyle(context),
                                ),
                              ],
                            ),
                          ),
                          spaceWidth(context, width: 0.02),
                          const LikeButton(),
                        ],
                      ),

                      Text(
                        house.houseName,
                        style: largeTextStyle(context),
                      ),
                      spaceHeight(context, height: 0.02),
                      Text(
                        "${house.street}, ${house.ward}, ${house.district}",
                        style: mediumTextStyle(context, color: Colors.grey),
                      ),
                      spaceHeight(context, height: 0.01),

                      // Consumer<FavouriteProvider>(
                      //     builder: (context, value, child) {
                      //   return LikeButton(
                      //     isLiked: value.isSaved(""),
                      //     onTap: (isLiked) async {
                      //       value.addFavouriteItem(
                      //           context.read<UserLoginProvider>().userPhone,
                      //           "");
                      //       return !isLiked;
                      //     },
                      //   );
                      // })
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
