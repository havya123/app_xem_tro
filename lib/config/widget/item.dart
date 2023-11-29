import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class Item extends StatelessWidget {
  Item({this.imageUrl, this.name, super.key});
  String? imageUrl;
  String? name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(Routes.overviewRote);
      },
      child: Ink(
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
                  image: imageUrl as String,
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
                                image: AssetImage(
                                    "assets/images/home_img/star.png"),
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
                          "Nhà trọ siêu cấp vip pro",
                          style: smallTextStyle(context, size: 0.02),
                        ),
                        spaceHeight(context, height: 0.01),
                        Text(
                          "Địa chỉ",
                          style: smallTextStyle(context,
                              color: Colors.grey, size: 0.018),
                        ),
                        spaceHeight(context, height: 0.01),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.bed),
                                spaceWidth(context, width: 0.02),
                                Text(
                                  "2 Room",
                                  style: smallTextStyle(context),
                                ),
                                spaceWidth(context, width: 0.04),
                                const Icon(Icons.bed),
                                spaceWidth(context, width: 0.02),
                                Text(
                                  "2 Room",
                                  style: smallTextStyle(context),
                                )
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ 526/month",
                                style: mediumTextStyle(
                                  context,
                                ),
                              ),
                              const LikeButton()
                              // Consumer<FavouriteProvider>(
                              //     builder: (context, value, child) {
                              //   return LikeButton(
                              //     isLiked: value.isSaved(""),
                              //     onTap: (isLiked) async {
                              //       value.addFavouriteItem(
                              //           context
                              //               .read<UserLoginProvider>()
                              //               .userPhone,
                              //           "");
                              //       return !isLiked;
                              //     },
                              //   );
                              // })
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
