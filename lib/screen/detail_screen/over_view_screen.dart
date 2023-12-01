import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/review.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<OverViewScreen> {
  Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    House house = arg['house'];
    String houseId = arg['houseId'];
    List<String> houseImage = house.img!.split(', ');
    final List<ImageProvider> imageProviders =
        houseImage.map((e) => Image.network(e).image).toList();
    List<String> facilities = house.facilities.split(', ');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: getHeight(context, height: 0.4),
              child: FadeInImage.memoryNetwork(
                width: double.infinity,
                height: getHeight(context, height: 0.4),
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: houseImage.first,
                imageErrorBuilder: (context, error, stackTrace) => Image.network(
                    "https://icons.veryicon.com/png/o/education-technology/alibaba-cloud-iot-business-department/image-load-failed.png"),
              ),
            ),
            spaceWidth(context),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding(context),
                vertical: padding(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        house.houseName,
                        style: largeTextStyle(context),
                      ),
                      spaceHeight(context, height: 0.01),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.heart)),
                    ],
                  ),
                  Text(
                    "${house.street}, ${house.ward}, ${house.district}, ${house.province} ",
                    style: mediumTextStyle(context, color: Colors.grey),
                  ),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Text(facilities[index]);
                      },
                      itemCount: facilities.length,
                    ),
                  ),
                  spaceHeight(context, height: 0.08),
                  ButtonWidget(
                      function: () {
                        MultiImageProvider multiImageProvider =
                            MultiImageProvider(imageProviders);
                        showImageViewerPager(context, multiImageProvider,
                            swipeDismissible: true, doubleTapZoomable: true);
                      },
                      textButton: "Xem toàn bộ hình ảnh"),
                  spaceHeight(context),
                  ButtonWidget(
                    function: () {
                      Get.toNamed(Routes.listRoomRouteUser, arguments: houseId);
                    },
                    textButton: "Danh sách phòng trọ",
                  ),
                  spaceHeight(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: mediumTextStyle(context),
                      ),
                      Text(
                        "Xem tat ca",
                        style: mediumTextStyle(context, color: Colors.blue),
                      ),
                    ],
                  ),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ReviewWidget();
                      },
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                      itemCount: 2)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
