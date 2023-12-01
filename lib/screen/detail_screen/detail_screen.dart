import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/confirm_form.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/desciption.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/list_services.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/map.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Room room = Get.arguments as Room;

  @override
  Widget build(BuildContext context) {
    List<String> listImg = room.img!.split(", ");
    List<String> listCate = [
      "4.1 (66 reviews)",
      "${room.numberOfPeople} người",
      "${room.numberOfFloor} tầng",
      "${room.acreage}m2",
    ];
    List<IconData> listIcon = [
      FontAwesomeIcons.star,
      FontAwesomeIcons.bed,
      FontAwesomeIcons.stairs,
      FontAwesomeIcons.square,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: getHeight(context, height: 0.3),
              child: FadeInImage.memoryNetwork(
                  width: double.infinity,
                  height: getHeight(context, height: 0.3),
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: listImg[0]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: padding(context), horizontal: padding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        room.roomId,
                        style: largeTextStyle(context),
                      ),
                      spaceHeight(context, height: 0.01),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.heart)),
                    ],
                  ),
                  // Text(
                  //   "${house.street}, ${house.ward}, ${house.district}, ${house.province} ",
                  //   style: mediumTextStyle(context, color: Colors.grey),
                  // ),
                  spaceHeight(context),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceWidget(
                          icon: listIcon[index], detail: listCate[index]);
                    },
                    itemCount: listIcon.length,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: getWidth(context, width: 0.2),
                        height: getHeight(context, height: 0.1),
                        child: const CircleAvatar(
                          backgroundColor: Colors.yellow,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chu tro",
                                style: mediumTextStyle(context),
                              ),
                              Text(
                                "+8412482184",
                                style: mediumTextStyle(context),
                              )
                            ],
                          )),
                      Expanded(
                          child: Container(
                        height: getHeight(context, height: 0.07),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow),
                      ))
                    ],
                  ),
                  spaceHeight(context),
                  Text(
                    "Dịch vụ",
                    style: largeTextStyle(context),
                  ),
                  spaceHeight(context),
                  const ListServicesWidget(),
                  spaceHeight(context),
                  const MapWidget(),
                  spaceHeight(context),
                  Text(
                    "Mô tả chi tiết",
                    style: largeTextStyle(context),
                  ),
                  spaceHeight(context, height: 0.02),
                  const DescriptionWidget(),
                  spaceHeight(context),

                  ButtonWidget(
                    function: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return const ConfirmFormWidget();
                        },
                      );
                    },
                    textButton: "Đặt lịch hẹn",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
