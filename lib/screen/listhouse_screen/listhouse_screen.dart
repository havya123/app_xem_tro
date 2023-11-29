import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListHouse extends StatefulWidget {
  const ListHouse({super.key});

  @override
  State<ListHouse> createState() => _ListHouseState();
}

class _ListHouseState extends State<ListHouse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getHeight(context, height: 0.02),
            vertical: getHeight(context, height: 0.02),
          ),
          child: SingleChildScrollView(
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
                spaceHeight(context, height: 0.01),
                FutureBuilder(
                    future: context.read<HouseProvider>().getListHouseLL(
                        context.read<UserLoginProvider>().userPhone),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Chua co phong"),
                        );
                      }
                      List<House> listHouse = snapshot.data as List<House>;

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
                                        'Nhà trọ ${index + 1}',
                                        style: mediumTextStyle(
                                          context,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Thêm nhà trọ',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    spaceWidth(context, width: 0.03),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.houseRegistrationRoute);
                                      },
                                      child: const Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ],
                                ),
                                spaceHeight(context, height: 0.02),
                                Item(
                                  imageUrl: listHouse[index].img,
                                ),
                                spaceHeight(context, height: 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.listRoomRoute);
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
