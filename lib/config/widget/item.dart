import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(
                borderRadius(context),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius(context)),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                          "assets/images/home_img/loading.gif"),
                      image:
                          const AssetImage("assets/images/home_img/home.png"),
                      imageErrorBuilder: (BuildContext context,
                          Object exception, StackTrace? stackTrace) {
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
                              style: smallTextStyle(context, size: 0.018),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$ 526/month",
                                    style: mediumTextStyle(
                                      context,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.heart,
                                        size: getWidth(context, width: 0.05),
                                      ))
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
        ),
      ),
    );
  }
}
