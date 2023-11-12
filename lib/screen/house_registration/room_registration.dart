import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomRegistration extends StatelessWidget {
  const RoomRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> number = ["1", "2", "3", "4"];
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
                      onTap: () {},
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
              TextFieldWidget(
                hint: "Mã phòng",
              ),
              spaceHeight(context),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tiện ích",
                    style: mediumTextStyle(context),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkBoxCombo(context, FontAwesomeIcons.fan, "Máy lạnh"),
                      checkBoxCombo(
                          context, FontAwesomeIcons.motorcycle, "Giữ xe")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkBoxCombo(context, FontAwesomeIcons.wifi, "Wifi"),
                      checkBoxCombo(
                          context, FontAwesomeIcons.doorClosed, "Nội thất")
                    ],
                  )
                ],
              ),
              spaceHeight(context, height: 0.03),
              Row(
                children: [
                  Text(
                    "Ở ghép",
                    style: mediumTextStyle(context),
                  ),
                  const CheckboxExample()
                ],
              ),
              spaceHeight(context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownWidget(context, number, "Số người"),
                  dropDownWidget(context, number, "Số tầng")
                ],
              ),
              spaceHeight(context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: getWidth(context, width: 0.45),
                      height: getHeight(context, height: 0.07),
                      child: TextFieldWidget(
                        hint: "Diện tích",
                        type: TextInputType.number,
                      )),
                  spaceWidth(
                    context,
                  ),
                  Text(
                    "m2",
                    style: mediumTextStyle(context),
                  )
                ],
              ),
              spaceHeight(context),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ảnh",
                  style: mediumTextStyle(context),
                ),
              ),
              spaceHeight(context, height: 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: getWidth(context, width: 0.5),
                  height: getHeight(context, height: 0.2),
                  decoration: BoxDecoration(
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
              spaceHeight(context),
              const Divider(
                color: Colors.black,
              ),
              spaceHeight(context),
              ButtonWidget(function: () {}, textButton: "Đăng ký"),
            ],
          ),
        ),
      ),
    );
  }

  Row checkBoxCombo(BuildContext context, IconData logo, String label) {
    return Row(
      children: [
        const CheckboxExample(),
        Icon(logo),
        spaceWidth(context),
        Text(
          label,
          style: mediumTextStyle(context),
        )
      ],
    );
  }

  DropdownMenu<String> dropDownWidget(
      context, List<String> location, String hint) {
    return DropdownMenu(
      width: getWidth(context, width: 0.4),
      hintText: hint,
      onSelected: (String? value) {},
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
