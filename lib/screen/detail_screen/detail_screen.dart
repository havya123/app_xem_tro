import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/facility_widget.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/confirm_form.dart';
import 'package:app_xem_tro/screen/detail_screen/widget/desciption.dart';
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
  late String houseAddess;
  String houseId = "";
  List<String> listImg = [];
  List<String> utilities = [];
  List<String> listCate = [];
  List<IconData> listIcon = [
    FontAwesomeIcons.star,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.stairs,
    FontAwesomeIcons.square,
  ];
  String landlordName = "";
  String landlordPhone = "";

  List<ImageProvider> imageProviders = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    room = arg['room'];
    roomId = arg['roomId'];
    houseAddess = arg['houseAddress'];
    houseId = arg['houseId'];
    listImg = room.img!.split(", ");
    utilities = room.utilities.split(" ,");
    listCate = [
      "4.1",
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
                      Consumer<User?>(
                        builder: (context, value, child) {
                          return Consumer<FavouriteProvider>(
                            builder: (context, value1, child) {
                              return value!.role == 0
                                  ? LikeButton(
                                      isLiked: value1.isSaved(roomId),
                                      onTap: (isLiked) async {
                                        await context
                                            .read<FavouriteProvider>()
                                            .saveItem(
                                                room.houseId,
                                                context
                                                    .read<UserLoginProvider>()
                                                    .userPhone,
                                                roomId,
                                                houseAddess)
                                            .then((value) async {
                                          await context
                                              .read<FavouriteProvider>()
                                              .loadWatchList(context
                                                  .read<UserLoginProvider>()
                                                  .userPhone);
                                        });

                                        return !isLiked;
                                      },
                                    )
                                  : Container(
                                      height: getHeight(context, height: 0.04),
                                      width: getWidth(context, width: 0.2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              room.bookingStatus == "available"
                                                  ? Colors.green
                                                  : Colors.red),
                                      child: Center(
                                        child: Text(
                                          room.bookingStatus,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ));
                            },
                          );
                        },
                      )
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
                                  const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                    ),
                                  ),
                                  spaceWidth(context, width: 0.02),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            landlordName,
                                            style: mediumTextStyle(context),
                                          ),
                                          Text(
                                            landlordPhone,
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
                        landlordName = user.name;
                        landlordPhone = user.phoneNumber;
                        landlordId = user.phoneNumber;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: user.avatar ?? "",
                                )),
                            spaceWidth(context),
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
                            Consumer<User?>(builder: (context, value, child) {
                              return value?.role == 0
                                  ? Expanded(
                                      child: Container(
                                      height: getHeight(context, height: 0.07),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child: IconButton(
                                          onPressed: () async {
                                            await context
                                                .read<MessageProvider>()
                                                .createRoomChat(
                                                    context
                                                        .read<
                                                            UserLoginProvider>()
                                                        .userPhone,
                                                    landlordId)
                                                .then((value) async {
                                              Get.toNamed(Routes.chatRoute,
                                                  arguments: [
                                                    context
                                                        .read<
                                                            UserLoginProvider>()
                                                        .userPhone,
                                                    landlordId
                                                  ]);
                                              await context
                                                  .read<MessageProvider>()
                                                  .loadRoomChat(context
                                                      .read<UserLoginProvider>()
                                                      .userPhone);
                                            });
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.message)),
                                    ))
                                  : const SizedBox();
                            })
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
                  Consumer<User>(
                    builder: (context, value, child) {
                      return value.role == 0
                          ? room.bookingStatus == 'booked'
                              ? const SizedBox()
                              : ButtonWidget(
                                  function: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return ConfirmFormWidget(
                                          roomId: roomId,
                                          landlordId: landlordId,
                                          landlordName: landlordName,
                                          landlordPhone: landlordPhone,
                                          houseAddress: houseAddess,
                                        );
                                      },
                                    );
                                  },
                                  textButton: "Đặt lịch hẹn",
                                )
                          : ButtonWidget(
                              function: () {
                                room.bookingStatus == "available"
                                    ? context
                                        .read<RoomRegisterProvider>()
                                        .bookedRoomStatus(roomId)
                                        .then((value) async {
                                        await context
                                            .read<RoomRegisterProvider>()
                                            .getListRoomLandlord(houseId);
                                      })
                                    : context
                                        .read<RoomRegisterProvider>()
                                        .availableRoomStatus(roomId)
                                        .then((value) async {
                                        await context
                                            .read<RoomRegisterProvider>()
                                            .getListRoomLandlord(houseId);
                                      });
                              },
                              textButton: "Thay đổi trạng thái phòng trọ",
                            );
                    },
                  )
                ],
              ),
            ),
            spaceHeight(context, height: 0.07),
          ],
        ),
      ),
    );
  }
}
