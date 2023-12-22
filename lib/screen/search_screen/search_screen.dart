import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/models/district.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/province.dart';
import 'package:app_xem_tro/models/ward.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/search_provider.dart';
import 'package:app_xem_tro/repository/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List places = [
    "TPHCM",
    "Hà Nội",
    "Hải Phòng",
    "Cà Mau",
  ];

  List numbers = ["1", "2", "3", "4"];
  bool isSelected = false;
  String province = "";
  String district = "";
  String ward = "";
  TextEditingController streetController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<GoogleMapProvider>().getListProvince();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: padding(context, padding: 0.01),
            vertical: padding(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SizedBox(
                      width: getWidth(context, width: 0.1),
                      height: getHeight(context, height: 0.06),
                      child: const Icon(FontAwesomeIcons.angleLeft),
                    ),
                  ),
                  spaceWidth(context, width: 0.02),
                  GestureDetector(
                    onTap: () => filterDialog(places, numbers, ward, district,
                        province, streetController),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: padding(context, padding: 0.03)),
                      width: getWidth(context, width: 0.7),
                      height: getHeight(context, height: 0.075),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Image.asset("assets/images/home_img/search.png"),
                          spaceWidth(context),
                          Text('Chọn địa chỉ',
                              style: smallTextStyle(context, size: 0.024))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.025),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              spaceHeight(context, height: 0.02),
              Padding(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder(
                    stream:
                        context.read<SearchProvider>().searchController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                            child: Text('Vui lòng chọn khu vực để tìm kiếm'));
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
                            "Không có dữ liệu về khu vực bạn tìm kiếm",
                            style: mediumTextStyle(context, color: Colors.blue),
                          ),
                        );
                      }
                      List listData = snapshot.data?['data'];
                      List<House> listHouse = listData[0];
                      List<String> listDoc = listData[1];
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
                                  houseId: listDoc[index],
                                ),
                                spaceHeight(context, height: 0.02),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          itemCount: listHouse.length);
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }

  filterDialog(
    List place,
    List number,
    String province,
    String district,
    String ward,
    TextEditingController streetController,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Bộ lộc tìm kiếm',
        ),
        content: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                                  .firstWhere((province) => province.name == p0)
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
                                  .firstWhere(
                                      (listDistrict) => listDistrict.name == p0)
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
                        ),
                        spaceHeight(context),
                        TextButton(
                            onPressed: () {
                              context
                                  .read<SearchProvider>()
                                  .searchList(streetController.text, ward,
                                      district, province)
                                  .then((value) => Get.back());
                            },
                            child: const Text('Search'))
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenu<String> dropDownProvince(context, List<Province> province,
      String hint, Function(String?)? onSelected) {
    return DropdownMenu(
      width: getWidth(context, width: 0.57),
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
      width: getWidth(context, width: 0.57),
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
      width: getWidth(context, width: 0.57),
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
