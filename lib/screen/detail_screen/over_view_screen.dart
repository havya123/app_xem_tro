import 'dart:async';

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/facility_widget.dart';
import 'package:app_xem_tro/config/widget/review.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<OverViewScreen> {
  Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>;
  late House house;
  late String houseId;
  List<String> houseImage = [];
  late List<ImageProvider> imageProviders = [];
  List<String> facilities = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    house = arg['house'];
    houseId = arg['houseId'];
    houseImage = house.img!.split(', ');
    imageProviders = houseImage.map((e) => Image.network(e).image).toList();
    facilities = house.facilities.split(' ,');
    context
        .read<GoogleMapProvider>()
        .setMaker(LatLng(house.lat.toDouble(), house.lng.toDouble()));
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    house.houseName,
                    style: largeTextStyle(context),
                  ),
                  spaceHeight(context, height: 0.01),
                  Text(
                    "${house.street}, ${house.ward}, ${house.district}, ${house.province} ",
                    style: mediumTextStyle(context, color: Colors.grey),
                  ),
                  spaceHeight(context),
                  Text(
                    'Cơ sở vật chất',
                    style: largeTextStyle(context),
                  ),
                  spaceHeight(context),
                  SizedBox(
                    height: getHeight(context, height: 0.18),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FacilityWidget(facility: facilities[index]);
                      },
                      separatorBuilder: (context, index) => spaceWidth(context),
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
                  Consumer<User?>(builder: (context, value, child) {
                    return value?.role == 0
                        ? ButtonWidget(
                            function: () {
                              Get.toNamed(Routes.listRoomRouteUser, arguments: {
                                'houseId': houseId,
                                'houseAddress':
                                    "${house.street}, ${house.ward}, ${house.district}, ${house.province}"
                              });
                            },
                            textButton: "Danh sách phòng trọ",
                          )
                        : ButtonWidget(
                            function: () {
                              Get.toNamed(Routes.listRoomRoute, arguments: {
                                'houseId': houseId,
                                'houseAddress':
                                    "${house.street}, ${house.ward}, ${house.district}, ${house.province}"
                              });
                            },
                            textButton: "Danh sách phòng trọ",
                          );
                  }),
                  spaceHeight(context),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Consumer<GoogleMapProvider>(
                            builder: (context, value, child) {
                          return GoogleMap(
                            mapType: MapType.normal,
                            markers: {value.marker},
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    house.lat.toDouble(), house.lng.toDouble()),
                                zoom: 24),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          );
                        }),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.mapRoute,
                                arguments: _controller);
                          },
                          icon: const Icon(FontAwesomeIcons.expand),
                        ),
                      ),
                    ],
                  ),
                  spaceHeight(context),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Review",
                  //       style: mediumTextStyle(context),
                  //     ),
                  //     Text(
                  //       "Xem tat ca",
                  //       style: mediumTextStyle(context, color: Colors.blue),
                  //     ),
                  //   ],
                  // ),
                  // ListView.separated(
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemBuilder: (context, index) {
                  //       return const ReviewWidget();
                  //     },
                  //     separatorBuilder: (context, index) =>
                  //         spaceHeight(context),
                  //     itemCount: 2)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
