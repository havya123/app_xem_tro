import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class ListRoom extends StatelessWidget {
  const ListRoom({super.key});
  @override
  Widget build(BuildContext context) {
    String arg = Get.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding(context),
            vertical: padding(context),
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaceHeight(context, height: 0.02),
                  Text(
                    'Danh sách phòng trọ của bạn',
                    style: largeTextStyle(context),
                  ),
                  SizedBox(
                    height: getHeight(context, height: 0.05),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Thêm phòng trọ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      spaceWidth(context, width: 0.03),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.roomRegistrationRoute,
                              arguments: arg);
                        },
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                  spaceHeight(context),
                  FutureBuilder(
                      future:
                          context.read<RoomRegisterProvider>().getListRoom(arg),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "Chưa Có Phòng Trọ, Đăng ký ngay",
                              style: mediumTextStyle(context),
                            ),
                          );
                        }
                        List<Room> listRoom = snapshot.data as List<Room>;
                        return ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Phòng trọ ${index + 1}',
                                          style: mediumTextStyle(
                                            context,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceHeight(context, height: 0.02),
                                  Item(
                                    imageUrl: listRoom[index].img,
                                  ),
                                  spaceHeight(context, height: 0.02),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                spaceHeight(context),
                            itemCount: listRoom.length);
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
