import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HouseRegistration extends StatelessWidget {
  const HouseRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> city = <String>["TPHCM", "Hà Nội", "Nha Trang", "Hải Phòng"];
    List<String> district = ["1", "2", "3", "4"];
    List<String> ward = ["1", "2", "3", "4"];
    List<String> street = ["1", "2", "3", "4"];
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
                'Đăng ký nhà trọ',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              TextFieldWidget(hint: 'Họ và tên'),
              spaceHeight(context, height: 0.03),
              TextFieldWidget(
                hint: "Số điện thoại",
                type: TextInputType.number,
              ),
              spaceHeight(context, height: 0.03),
              TextFieldWidget(
                hint: "Địa chỉ hiện tại",
                icon: const Icon(FontAwesomeIcons.mapLocationDot),
              ),
              spaceHeight(context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownWidget(context, city, "Thành phố/Tỉnh"),
                  dropDownWidget(context, district, "Quận/Huyện")
                ],
              ),
              spaceHeight(context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dropDownWidget(context, ward, "Phường/Xã"),
                  dropDownWidget(context, street, "Đường")
                ],
              ),
              spaceHeight(context),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Image.asset(
                  "assets/images/map_img/map.png",
                ),
              ),
              spaceHeight(
                context,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cơ sở vật chất gần nhà trọ",
                  style: mediumTextStyle(
                    context,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkBoxCombo(
                          context, FontAwesomeIcons.cartShopping, "Chợ"),
                      checkBoxCombo(context, FontAwesomeIcons.store, "Cửa hàng")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkBoxCombo(
                          context, FontAwesomeIcons.mugSaucer, "Cafe"),
                      checkBoxCombo(
                          context, FontAwesomeIcons.water, "Tiệm giặt")
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const CheckboxExample(),
                  Text(
                    "Khác...",
                    style: mediumTextStyle(context),
                  )
                ],
              ),
              spaceHeight(context),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mô tả",
                  style: mediumTextStyle(context),
                ),
              ),
              spaceHeight(context, height: 0.03),
              Container(
                width: double.infinity,
                height: getHeight(context, height: 0.35),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
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

  Container checkBoxCombo(BuildContext context, IconData logo, String label) {
    return Container(
      child: Row(
        children: [
          const CheckboxExample(),
          Icon(logo),
          spaceWidth(context),
          Text(
            label,
            style: mediumTextStyle(context),
          )
        ],
      ),
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
