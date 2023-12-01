import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListRoomUserScreen extends StatelessWidget {
  const ListRoomUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String arg = Get.arguments as String;
    context.read<RoomRegisterProvider>().getListRoom(arg);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      return const Center(child: CircularProgressIndicator());
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
                        child: Text(
                          "Chưa có phòng trọ",
                          style: mediumTextStyle(context, color: Colors.blue),
                        ),
                      );
                    }
                    List<Room> listRoom = snapshot.data?['data'] as List<Room>;
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
                              // HouseItem(
                              //   imageUrl: listRoom[index].img,
                              // ),
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
    );
  }
}