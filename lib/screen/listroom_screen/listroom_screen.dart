import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/config/widget/room_item.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListRoom extends StatelessWidget {
  const ListRoom({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>;
    String houseId = arg['houseId'];
    String houseAddress = arg['houseAddress'];
    context.read<RoomRegisterProvider>().getListRoomLandlord(houseId);
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
                              arguments: houseId);
                        },
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                  spaceHeight(context),
                  StreamBuilder(
                      stream: context
                          .read<RoomRegisterProvider>()
                          .roomController
                          .stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data?['status'] == statusCode.loading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.data!['data'].length == 0) {
                          return Center(
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.houseRegistrationRoute);
                              },
                              child: Text(
                                "Chưa có phòng trọ, Thêm Ngay!!! ",
                                style: mediumTextStyle(context,
                                    color: Colors.blue),
                              ),
                            ),
                          );
                        }
                        List<Room> listRoom =
                            snapshot.data?['data'] as List<Room>;
                        return ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listRoom[index].roomId,
                                    style: mediumTextStyle(
                                      context,
                                    ),
                                  ),
                                  spaceHeight(context, height: 0.02),
                                  RoomItem(
                                      houseId: houseId,
                                      houseAddress: houseAddress,
                                      room: listRoom[index],
                                      roomId: context
                                          .read<RoomRegisterProvider>()
                                          .listRoomId[index]),
                                  spaceHeight(context, height: 0.02),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                spaceHeight(context),
                            itemCount: listRoom.length);
                      })
                ]),
          ),
        ),
      ),
    );
  }
}
