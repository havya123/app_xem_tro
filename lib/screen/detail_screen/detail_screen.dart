import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/facility_widget.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/confirm_form.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/desciption.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/list_services.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/map.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>;
  late Room room;
  late String roomId;
  late String landlordId;
  List<String> listImg = [];
  List<String> utilities = [];
  List<String> listCate = [];
  List<IconData> listIcon = [
    FontAwesomeIcons.star,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.stairs,
    FontAwesomeIcons.square,
  ];

  List<ImageProvider> imageProviders = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    room = arg['room'];
    roomId = arg['roomId'];
    listImg = room.img!.split(", ");
    utilities = room.utilities.split(" ,");
    listCate = [
      "4.1 (66 reviews)",
      "${room.numberOfPeople} người",
      "${room.numberOfFloor} tầng",
      "${room.acreage}m2",
    ];
    imageProviders = listImg.map((e) => Image.network(e).image).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                      Consumer<FavouriteProvider>(
                        builder: (context, value, child) {
                          return Positioned(
                              right: 0,
                              child: LikeButton(
                                isLiked: value.isSaved(roomId),
                                onTap: (isLiked) async {
                                  context
                                      .read<FavouriteProvider>()
                                      .addFavouriteItem(
                                          room.houseId,
                                          context
                                              .read<UserLoginProvider>()
                                              .userPhone,
                                          roomId);
                                  context
                                      .read<FavouriteProvider>()
                                      .loadWatchList();
                                  return !isLiked;
                                },
                              ));
                        },
                      ),
                    ],
                  ),
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
                  spaceHeight(context),
                  ButtonWidget(
                      function: () {
                        MultiImageProvider multiImageProvider =
                            MultiImageProvider(imageProviders);
                        showImageViewerPager(context, multiImageProvider,
                            swipeDismissible: true, doubleTapZoomable: true);
                      },
                      textButton: "Xem toàn bộ hình ảnh"),
                  spaceHeight(context, height: 0.08),
                  FutureBuilder(
                      future: context
                          .read<RoomRegisterProvider>()
                          .getLandLord(room.houseId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                ]),
                          );
                        }

                        User user = snapshot.data as User;
                        landlordId = user.phoneNumber;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: getWidth(context, width: 0.2),
                                height: getHeight(context, height: 0.1),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: user.avatar ?? "",
                                )),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      user.name,
                                      style: mediumTextStyle(context),
                                    ),
                                    Text(
                                      user.phoneNumber,
                                      style: mediumTextStyle(context),
                                    )
                                  ],
                                )),
                            Expanded(
                                child: Container(
                              height: getHeight(context, height: 0.07),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: IconButton(
                                  onPressed: () async {
                                    await context
                                        .read<MessageProvider>()
                                        .createRoomChat(
                                            context
                                                .read<UserLoginProvider>()
                                                .userPhone,
                                            landlordId)
                                        .then((value) => Get.toNamed(
                                                Routes.chatRoute,
                                                arguments: [
                                                  context
                                                      .read<UserLoginProvider>()
                                                      .userPhone,
                                                  landlordId
                                                ]));
                                  },
                                  icon: const Icon(FontAwesomeIcons.message)),
                            ))
                          ],
                        );
                      }),
                  spaceHeight(context),
                  Text(
                    "Dịch vụ",
                    style: largeTextStyle(context),
                  ),
                  spaceHeight(context),
                  SizedBox(
                    height: getHeight(context, height: 0.18),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return FacilityWidget(facility: utilities[index]);
                      },
                      separatorBuilder: (context, index) => spaceWidth(context),
                      itemCount: utilities.length,
                    ),
                  ),
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
