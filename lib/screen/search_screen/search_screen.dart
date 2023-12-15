import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/repository/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: getWidth(context, width: 0.1),
                    height: getHeight(context, height: 0.06),
                    child: const Icon(FontAwesomeIcons.angleLeft),
                  ),
                  spaceWidth(context, width: 0.02),
                  Container(
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
                        GestureDetector(
                          onTap: () => SearchRepository().searchHouse(),
                          child: Text('Bình Thạnh',
                              style: smallTextStyle(context, size: 0.024)),
                        )
                      ],
                    ),
                  ),
                  spaceWidth(context, width: 0.015),
                  InkWell(
                    onTap: () => filterDialog(places, numbers),
                    child: Container(
                      width: getWidth(context, width: 0.13),
                      height: getHeight(context, height: 0.075),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: const Icon(FontAwesomeIcons.sliders),
                    ),
                  )
                ],
              ),
              spaceHeight(context, height: 0.025),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              spaceHeight(context, height: 0.02),
              Padding(
                padding: EdgeInsets.only(
                    left: padding(context, padding: 0.02),
                    right: padding(context, padding: 0.08)),
              )
            ],
          ),
        ),
      ),
    ));
  }

  filterDialog(List place, List number) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                Text(
                  "Vị trí",
                  style: smallTextStyle(context,
                      size: 0.023, color: Colors.grey.shade600),
                ),
                GridView.builder(
                  itemCount: place.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return ChoiceChip(
                          label: SizedBox(
                              width: getWidth(context, width: 0.2),
                              height: getHeight(context, height: 0.05),
                              child: Center(child: Text(place[index]))),
                          selected: isSelected,
                          selectedColor: Colors.blue,
                          onSelected: (newState) {
                            setState(() {
                              isSelected = newState;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                Center(
                  child: SizedBox(
                    width: getWidth(context, width: 0.25),
                    height: getHeight(context, height: 0.06),
                    child: const TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Center(child: Text("...")),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ),
                spaceHeight(context, height: 0.023),
                const Divider(
                  color: Colors.black,
                ),
                Text(
                  "Khoảng giá",
                  style: smallTextStyle(context,
                      size: 0.023, color: Colors.grey.shade600),
                ),
                spaceHeight(context, height: 0.023),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: getWidth(context, width: 0.45),
                        height: getHeight(context, height: 0.07),
                        child: TextFieldWidget(
                          hint: "Tối thiểu",
                          type: TextInputType.number,
                        )),
                    Text(
                      "VND",
                      style: mediumTextStyle(context),
                    )
                  ],
                ),
                spaceHeight(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: getWidth(context, width: 0.45),
                        height: getHeight(context, height: 0.07),
                        child: TextFieldWidget(
                          hint: "Tối đa",
                          type: TextInputType.number,
                        )),
                    Text(
                      "VND",
                      style: mediumTextStyle(context),
                    )
                  ],
                ),
                spaceHeight(context, height: 0.023),
                const Divider(
                  color: Colors.black,
                ),
                Text(
                  "Số lượng người ở",
                  style: smallTextStyle(context,
                      size: 0.023, color: Colors.grey.shade600),
                ),
                GridView.builder(
                  itemCount: number.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return ChoiceChip(
                          label: SizedBox(
                              width: getWidth(context, width: 0.1),
                              height: getHeight(context, height: 0.025),
                              child: Center(child: Text(number[index]))),
                          selected: isSelected,
                          selectedColor: Colors.blue,
                          onSelected: (newState) {
                            setState(() {
                              isSelected = newState;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                Center(
                  child: SizedBox(
                    width: getWidth(context, width: 0.15),
                    height: getHeight(context, height: 0.035),
                    child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Center(child: Text("...")),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ),
                spaceHeight(context, height: 0.023),
                const Divider(
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      "Ở ghép",
                      style: smallTextStyle(context,
                          size: 0.023, color: Colors.grey.shade600),
                    ),
                    // const CheckboxExample()
                  ],
                ),
                spaceHeight(context, height: 0.05),
                Center(
                  child: SizedBox(
                      width: getWidth(context, width: 0.5),
                      height: getHeight(context, height: 0.05),
                      child: ButtonWidget(
                        function: () {
                          Navigator.pop(context);
                        },
                        textButton: "Xác nhận",
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
