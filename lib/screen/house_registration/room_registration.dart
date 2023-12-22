import 'dart:io';

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/image_room_selected.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RoomRegistration extends StatefulWidget {
  const RoomRegistration({super.key});

  @override
  State<RoomRegistration> createState() => _RoomRegistrationState();
}

class _RoomRegistrationState extends State<RoomRegistration> {
  String houseId = Get.arguments as String;
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  void isChoosed(bool isCheck) {
    isChecked = isCheck;
  }

  List<String> getFacility = [];

  List logo = [
    FontAwesomeIcons.fan,
    FontAwesomeIcons.wifi,
    FontAwesomeIcons.motorcycle,
    FontAwesomeIcons.doorClosed
  ];

  List label = ["Máy lạnh", "Wifi", "Giữ xe", "Nội thất"];

  String numberOfPeople = "";
  String numberOfFloor = "";
  TextEditingController roomIdController = TextEditingController();
  TextEditingController acreageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> number = ["1", "2", "3", "4"];
    String userPhone = context.read<UserLoginProvider>().userPhone;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: padding(context, padding: 0.12),
            horizontal: padding(context, padding: 0.05)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: getHeight(context, height: 0.4),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/login_img/home_icon.png',
                          fit: BoxFit.cover,
                        )),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: getWidth(context, width: 0.12),
                        height: getHeight(context, height: 0.06),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: const Icon(FontAwesomeIcons.arrowLeft),
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                'Đăng ký phòng trọ',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hint: "Tên phòng",
                        controller: roomIdController,
                        errorText: "Hãy nhập tên phòng",
                      ),
                      spaceHeight(context, height: 0.03),
                      TextFieldWidget(
                        hint: "Diện tích (m2)",
                        type: TextInputType.number,
                        controller: acreageController,
                        errorText: "Hãy nhập diện tích",
                      ),
                      spaceHeight(context, height: 0.03),
                      TextFieldWidget(
                        hint: "Giá",
                        type: TextInputType.number,
                        controller: priceController,
                        errorText: "Hãy nhập giá tiền",
                      ),
                    ],
                  )),
              spaceHeight(context),
              spaceHeight(context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownWidget(context, number, "Số người", (p0) {
                    numberOfPeople = p0!;
                  }),
                  dropDownWidget(context, number, "Số tầng", (p0) {
                    numberOfFloor = p0!;
                  })
                ],
              ),
              spaceHeight(context),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tiện ích",
                    style: mediumTextStyle(context),
                  )),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return checkBoxCombo(context, logo[index], label[index]);
                  }),
              spaceHeight(context),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "Ảnh",
                      style: mediumTextStyle(context),
                    ),
                    spaceWidth(context),
                    Consumer<RoomRegisterProvider>(
                      builder: (context, value, child) {
                        return Text("Tối thiểu ${value.countItem}/3 ảnh");
                      },
                    )
                  ],
                ),
              ),
              spaceHeight(context),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const ImageRoomSelected();
                          });
                    },
                    child: Container(
                      width: getWidth(context, width: 0.5),
                      height: getHeight(context, height: 0.2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          SizedBox(
                              width: getWidth(context, width: 0.5),
                              height: getHeight(context, height: 0.15),
                              child: Image.asset(
                                "assets/images/camera_img/camera_img.png",
                                fit: BoxFit.fitHeight,
                              )),
                          Text(
                            "Thêm ảnh",
                            style: mediumTextStyle(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceHeight(context),
              Align(
                alignment: Alignment.centerLeft,
                child: Consumer<RoomRegisterProvider>(
                    builder: (context, value, child) {
                  if (value.selectedImageRoom.isEmpty) {
                    return const SizedBox();
                  }
                  return SizedBox(
                    height: getHeight(context, height: 0.2),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: getWidth(context, width: 0.5),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.file(
                                  File(value.selectedImageRoom[index]!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<RoomRegisterProvider>()
                                            .deleteImageRoom(index);
                                      },
                                      icon: const Icon(FontAwesomeIcons.xmark)))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            spaceWidth(context),
                        itemCount: value.selectedImageRoom.length),
                  );
                }),
              ),
              spaceHeight(context),
              const Divider(
                color: Colors.black,
              ),
              spaceHeight(context),
              ButtonWidget(
                  function: () async {
                    String facilities = getFacility.join(' ,');

                    if (formKey.currentState!.validate() &&
                        context
                                .read<RoomRegisterProvider>()
                                .selectedImageRoom
                                .length >=
                            3) {
                      await context
                          .read<RoomRegisterProvider>()
                          .roomRegistration(
                              houseId,
                              roomIdController.text,
                              userPhone,
                              facilities,
                              numberOfPeople,
                              numberOfFloor,
                              acreageController.text,
                              "",
                              priceController.text)
                          .then((value) async {
                        await context
                            .read<RoomRegisterProvider>()
                            .uploadImg(userPhone, houseId)
                            .then((value) => Get.back());
                      });
                    }
                  },
                  textButton: "Đăng ký"),
            ],
          ),
        ),
      ),
    );
  }

  Row checkBoxCombo(BuildContext context, IconData logo, String label) {
    return Row(
      children: [
        CheckboxExample(isChecked: (p0) {
          isChoosed(p0!);
          if (isChecked == true && !getFacility.contains(label)) {
            getFacility.add(label);
            return;
          }
          if (isChecked == false && getFacility.contains(label)) {
            getFacility.remove(label);
            return;
          }
        }),
        Icon(logo),
        spaceWidth(context),
        Text(
          label,
          style: smallMediumTextStyle(context),
        )
      ],
    );
  }

  DropdownMenu<String> dropDownWidget(
      context, List<String> location, String hint, Function(String?) amount) {
    return DropdownMenu(
      width: getWidth(context, width: 0.4),
      hintText: hint,
      onSelected: (String? value) {
        amount(value);
      },
      dropdownMenuEntries:
          location.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
    );
  }
}
