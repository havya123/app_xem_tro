import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/room_item.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListRoomUserScreen extends StatelessWidget {
  const ListRoomUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = Get.arguments as Map<String, dynamic>;
    String houseId = arg['houseId'];
    String houseAddress = arg['houseAddress'];
    context.read<RoomRegisterProvider>().getListRoom(houseId);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Danh sách các phòng trọ",
                  style: largeTextStyle(context),
                ),
                spaceHeight(context),
                StreamBuilder(
                    stream: context
                        .read<RoomRegisterProvider>()
                        .roomController
                        .stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  spaceHeight(context),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: getHeight(context, height: 0.4),
                                  margin:
                                      EdgeInsets.only(right: padding(context)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                );
                              },
                            ));
                      }
                      if (snapshot.data?['status'] == statusCode.loading) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  spaceHeight(context),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: getHeight(context, height: 0.4),
                                  margin:
                                      EdgeInsets.only(right: padding(context)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                );
                              },
                            ));
                      }
                      if (snapshot.data!['data'].length == 0) {
                        return Center(
                          child: Text(
                            "Chưa có phòng trọ",
                            style: mediumTextStyle(context, color: Colors.blue),
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
                                  room: listRoom[index],
                                  roomId: context
                                      .read<RoomRegisterProvider>()
                                      .listRoomId[index],
                                  houseAddress: houseAddress,
                                ),
                                spaceHeight(context, height: 0.02),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          itemCount: listRoom.length);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
