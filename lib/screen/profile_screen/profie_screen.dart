// ignore_for_file: use_build_context_synchronously

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/profile_screen/detail_profile_screen.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: padding(context), vertical: padding(context)),
          child: Column(children: [
            spaceHeight(context, height: 0.01),
            SizedBox(
              width: getWidth(context, width: 0.4),
              height: getHeight(context, height: 0.23),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("assets/images/splash_img/splash_icon.png",
                    fit: BoxFit.cover),
              ),
            ),
            const Text("Tran Nguyen Hieu Trung",
                style: TextStyle(fontSize: 20)),
            spaceHeight(context),
            const Divider(color: Colors.black87),
            ButtonListTile(
              title: 'Thông tin cá nhân',
              icon: FontAwesomeIcons.userLarge,
              iconbutton: FontAwesomeIcons.angleRight,
              onPress: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailProfileScreen()),
                );
              },
            ),
            ButtonListTile(
              title: 'Cài đặt',
              icon: FontAwesomeIcons.gear,
              iconbutton: FontAwesomeIcons.angleRight,
              onPress: () {},
            ),
            ButtonListTile(
              title: 'Lịch hẹn',
              icon: CommunityMaterialIcons.calendar_clock,
              iconbutton: FontAwesomeIcons.angleRight,
              onPress: () {},
            ),
            ButtonListTile(
              title: 'FAQ',
              icon: CommunityMaterialIcons.comment_question,
              iconbutton: FontAwesomeIcons.angleRight,
              onPress: () {},
            ),
            spaceHeight(context),
            const Divider(color: Colors.black87),
            spaceHeight(context),
            ButtonWidget(
              function: () async {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              textButton: "Đăng xuất",
            ),
          ]),
        ),
      ),
    );
  }
}
