import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListHouse extends StatefulWidget {
  const ListHouse({super.key});

  @override
  State<ListHouse> createState() => _ListHouseState();
}

class _ListHouseState extends State<ListHouse> {
  @override
  Widget build(BuildContext context) {
    context
        .read<HouseProvider>()
        .getListHouseLL(context.read<UserLoginProvider>().userPhone);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getHeight(context, height: 0.02),
              vertical: getHeight(context, height: 0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Danh sách nhà trọ của bạn',
                    style: largeTextStyle(context, size: 0.04),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, height: 0.05),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Thêm nhà trọ',
                      style: mediumTextStyle(context, color: Colors.blue),
                    ),
                    spaceWidth(context, width: 0.03),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.houseRegistrationRoute,
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                spaceHeight(context, height: 0.01),
                StreamBuilder(
                    stream:
                        context.read<HouseProvider>().houseController.stream,
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
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.houseRegistrationRoute);
                            },
                            child: Text(
                              "Chưa có nhà trọ, Thêm Ngay!!! ",
                              style:
                                  mediumTextStyle(context, color: Colors.blue),
                            ),
                          ),
                        );
                      }
                      List<House> listHouse =
                          snapshot.data?['data'] as List<House>;
                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listHouse[index].houseName,
                                  style: mediumTextStyle(
                                    context,
                                  ),
                                ),
                                spaceHeight(context, height: 0.02),
                                HouseItem(
                                  house: listHouse[index],
                                  houseId: context
                                      .read<HouseProvider>()
                                      .listDoc[index],
                                ),
                                spaceHeight(context, height: 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.listRoomRoute,
                                              arguments: {
                                                'houseId': context
                                                    .read<HouseProvider>()
                                                    .listDoc[index],
                                                "houseAddress":
                                                    listHouse[index].fullAddress
                                              });
                                        },
                                        child: Text(
                                          "Xem tất cả phòng trọ ",
                                          style: mediumTextStyle(context,
                                              color: Colors.blue),
                                        )),
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          itemCount: listHouse.length);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
