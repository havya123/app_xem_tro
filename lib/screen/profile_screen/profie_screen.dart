// ignore_for_file: use_build_context_synchronously

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({this.controller, super.key});

  PersistentTabController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<User?>(builder: (context, value, child) {
        if (value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeight(context),
              Row(
                children: [
                  Consumer<User?>(builder: (context, value, child) {
                    if (value!.address.isEmpty) {
                      return Container(
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.1)),
                        child: Image.asset(
                            "assets/images/splash_img/splash_icon.png",
                            fit: BoxFit.cover),
                      );
                    }
                    return Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Image.network(value.avatar as String,
                          fit: BoxFit.cover),
                    );
                  }),
                  spaceWidth(context),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value.name,
                          style: largeTextStyle(context, size: 0.05)),
                    ],
                  )),
                ],
              ),
              spaceHeight(context),
              const Divider(),
              spaceHeight(context, height: 0.04),
              options(
                context,
                "assets/images/profile_img/profile.png",
                "Quản lý thông tin cá nhân",
                () => Get.toNamed(Routes.detailProfileRoute),
              ),
              spaceHeight(context, height: 0.05),
              options(
                context,
                "assets/images/profile_img/setting.png",
                "Cài đặt",
                () {},
              ),
              spaceHeight(context, height: 0.05),
              options(
                context,
                "assets/images/profile_img/schedule.png",
                "Lịch hẹn",
                () {
                  Get.toNamed(Routes.bookingroute);
                },
              ),
              spaceHeight(context, height: 0.05),
              options(
                context,
                "assets/images/profile_img/question.png",
                "FAQ",
                () {},
              ),
              spaceHeight(
                context,
              ),
              const Divider(),
              spaceHeight(
                context,
              ),
              ButtonWidget(
                function: () async {
                  await context
                      .read<UserLoginProvider>()
                      .logOut()
                      .then((value) => controller!.jumpToTab(0));
                },
                textButton: "Đăng xuất",
              ),
              spaceHeight(context),
            ],
          ),
        ));
      }),
    );
  }

  Row options(
    context,
    String image,
    String name,
    Function function,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Set the shadow color
                spreadRadius: 5.0, // Set the spread offset
                blurRadius: 5.0,
                offset: const Offset(0, 1), // Set the offset
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              image,
            ),
          ),
        ),
        spaceWidth(context),
        Expanded(
          child: Text(
            name,
            style: mediumTextStyle(context),
          ),
        ),
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffF6F5F8),
            ),
            child: Center(
                child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                function();
              },
            ))),
      ],
    );
  }
}
