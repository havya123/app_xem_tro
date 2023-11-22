import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/navigationlisthouse_screen/navigationlisthouse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ListHouse extends StatelessWidget {
  const ListHouse({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getHeight(context, height: 0.02),
            vertical: getHeight(context, height: 0.02),
          ),
          child: Column(
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
                  const Text(
                    'Thêm nhà trọ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  spaceWidth(context, width: 0.03),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.houseRegistrationRoute);
                    },
                    child: const Icon(
                      Icons.add_alarm,
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Nhà trọ 1',
                    style: mediumTextStyle(
                      context,
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.02),
              SizedBox(
                height: getHeight(context, height: 0.2),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Item();
                    },
                    separatorBuilder: (context, index) {
                      return spaceWidth(context);
                    },
                    itemCount: 5),
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
                        style: mediumTextStyle(context, color: Colors.blue),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Nhà trọ 2',
                    style: mediumTextStyle(
                      context,
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.02),
              SizedBox(
                height: getHeight(context, height: 0.2),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Item();
                    },
                    separatorBuilder: (context, index) {
                      return spaceWidth(context);
                    },
                    itemCount: 5),
              ),
              spaceHeight(context, height: 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Xem tất cả phòng trọ ",
                      style: mediumTextStyle(context, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
