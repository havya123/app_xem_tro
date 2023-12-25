import 'dart:async';
import 'dart:io';

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/select_image.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HouseRegistration extends StatefulWidget {
  const HouseRegistration({super.key});

  @override
  State<HouseRegistration> createState() => _HouseRegistrationState();
}

class _HouseRegistrationState extends State<HouseRegistration> {
  @override
  void initState() {
    context.read<GoogleMapProvider>().getListProvince();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String province = "";
  String district = "";
  String ward = "";
  final formKey = GlobalKey<FormState>();
  String errorTextProvince = "Vui lòng chọn Tỉnh/TP";
  String errorTextDistrict = "Vui lòng chọn Quận/Huyện";
  String errorTextWard = "";

  TextEditingController streetController = TextEditingController();

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Không tìm thấy địa điểm của bạn"),
          content: const Text(
              "Không tìm thấy địa điểm của bạn, xin vui lòng thử lại"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Ok"))
          ],
        );
      },
    );
  }

  List logo = [
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.store,
    FontAwesomeIcons.mugSaucer,
    FontAwesomeIcons.water,
    FontAwesomeIcons.school,
    FontAwesomeIcons.hospital
  ];

  List label = [
    "Chợ",
    "Cửa hàng",
    "Cafe",
    "Tiệm giặt",
    "Trường học",
    "Bệnh viện"
  ];

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> getFacility = [];

  bool isChecked = false;
  void isChoosed(bool isCheck) {
    isChecked = isCheck;
  }

  @override
  Widget build(BuildContext context) {
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
                'Đăng ký nhà trọ',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Column(
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            hint: 'Họ và tên',
                            controller: userNameController,
                            errorText: "Hãy nhập họ và tên",
                          ),
                          spaceHeight(context, height: 0.03),
                          TextFieldWidget(
                            hint: "Số điện thoại",
                            type: TextInputType.number,
                            controller: phoneNumberController,
                            errorText: "Hãy nhập số điện thoại",
                          ),
                          spaceHeight(context, height: 0.03),
                          TextFieldWidget(
                            hint: 'Nhập tên nhà trọ',
                            controller: houseNameController,
                            errorText: "Hãy nhập tên nhà trọ",
                          ),
                          spaceHeight(context, height: 0.03),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Địa chỉ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          spaceHeight(context, height: 0.01),
                          Consumer<GoogleMapProvider>(
                              builder: (context, value, child) {
                            return dropDownProvince(
                              context,
                              value.listProvince,
                              "Tỉnh/TP",
                              (p0) {
                                province = p0 as String;
                                int code = value.listProvince
                                    .firstWhere(
                                        (province) => province.name == p0)
                                    .code;

                                context
                                    .read<GoogleMapProvider>()
                                    .getListDistrict(code);
                              },
                            );
                          }),
                          spaceHeight(context, height: 0.03),
                          Consumer<GoogleMapProvider>(
                              builder: (context, value, child) {
                            return dropDownDistrict(
                              context,
                              value.listDistrict,
                              "Quận/Huyện",
                              (p0) {
                                district = p0 as String;
                                int code = value.listDistrict
                                    .firstWhere((listDistrict) =>
                                        listDistrict.name == p0)
                                    .code;
                                context
                                    .read<GoogleMapProvider>()
                                    .getListWard(code);
                              },
                            );
                          }),
                          spaceHeight(context, height: 0.03),
                          Consumer<GoogleMapProvider>(
                              builder: (context, value, child) {
                            return dropDownWard(
                              context,
                              value.listWard,
                              "Phường/Xã",
                              (p0) {
                                ward = p0 as String;
                              },
                            );
                          }),
                          spaceHeight(context, height: 0.03),
                          TextFieldWidget(
                            errorText: "Vui lòng nhập đầy đủ địa chỉ",
                            hint: "Đường",
                            controller: streetController,
                            function: (p0) async {
                              await context
                                  .read<GoogleMapProvider>()
                                  .searchPlace("$province $district $ward $p0",
                                      showErrorDialog)
                                  .then((value) async {
                                context
                                    .read<GoogleMapProvider>()
                                    .goToPlace(_controller);
                              });
                            },
                          ),
                        ],
                      )),
                ],
              ),
              spaceHeight(context),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Consumer<GoogleMapProvider>(
                        builder: (context, value, child) {
                      return GoogleMap(
                        mapType: MapType.normal,
                        markers: {value.marker},
                        initialCameraPosition:
                            CameraPosition(target: value.latLng, zoom: 24),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      );
                    }),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.mapRoute, arguments: _controller);
                      },
                      icon: const Icon(FontAwesomeIcons.expand),
                    ),
                  ),
                ],
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
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return checkBoxCombo(context, logo[index], label[index]);
                  }),
              Text(
                "Khác...",
                style: mediumTextStyle(context),
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
                child: Padding(
                    padding: EdgeInsets.all(padding(context, padding: 0.02)),
                    child: TextFieldWidget(
                      hint: "",
                      controller: descriptionController,
                      minLetter: 50,
                      errorText: "Hãy nhập thông tin mô tả",
                      errorPass: "Nhập ít nhất 100 ký tự",
                      removeBorder: true,
                    )),
              ),
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
                    Consumer<HouseProvider>(
                      builder: (context, value, child) {
                        return Text('Tối thiểu ${value.countImage}/3');
                      },
                    )
                  ],
                ),
              ),
              spaceHeight(context, height: 0.03),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const ImageSelected();
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
                child:
                    Consumer<HouseProvider>(builder: (context, value, child) {
                  if (value.selectedImageHouse.isEmpty) {
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
                                  File(value.selectedImageHouse[index]!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<HouseProvider>()
                                            .deleteImage(index);
                                      },
                                      icon: const Icon(FontAwesomeIcons.xmark)))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            spaceWidth(context),
                        itemCount: value.selectedImageHouse.length),
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
                                .read<HouseProvider>()
                                .selectedImageHouse
                                .length >=
                            3) {
                      context
                          .read<HouseProvider>()
                          .houseRegistration(
                              userNameController.text,
                              userPhone,
                              phoneNumberController.text,
                              houseNameController.text,
                              province,
                              district,
                              ward,
                              streetController.text,
                              context.read<GoogleMapProvider>().latLng.latitude,
                              context
                                  .read<GoogleMapProvider>()
                                  .latLng
                                  .longitude,
                              facilities,
                              descriptionController.text)
                          .then((value) async {
                        await context
                            .read<HouseProvider>()
                            .uploadImg(userPhone)
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
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  DropdownMenu<String> dropDownProvince(context, List<Province> province,
      String hint, Function(String?)? onSelected) {
    return DropdownMenu(
      width: getWidth(context, width: 0.9),
      hintText: hint,
      onSelected: (String? value) {
        onSelected!(value);
      },
      dropdownMenuEntries:
          province.map<DropdownMenuEntry<String>>((Province province) {
        return DropdownMenuEntry<String>(
          value: province.name,
          label: province.name,
        );
      }).toList(),
    );
  }

  DropdownMenu<String> dropDownDistrict(context, List<District> district,
      String hint, Function(String?)? onSelected) {
    return DropdownMenu(
      width: getWidth(context, width: 0.9),
      hintText: hint,
      onSelected: (String? value) {
        onSelected!(value);
      },
      dropdownMenuEntries:
          district.map<DropdownMenuEntry<String>>((District district) {
        return DropdownMenuEntry<String>(
          value: district.name,
          label: district.name,
        );
      }).toList(),
    );
  }

  DropdownMenu<String> dropDownWard(
      context, List<Ward> ward, String hint, Function(String?)? onSelected) {
    return DropdownMenu(
      width: getWidth(context, width: 0.9),
      hintText: hint,
      onSelected: (String? value) {
        onSelected!(value);
      },
      dropdownMenuEntries: ward.map<DropdownMenuEntry<String>>((Ward ward) {
        return DropdownMenuEntry<String>(
          value: ward.name,
          label: ward.name,
        );
      }).toList(),
    );
  }
}
