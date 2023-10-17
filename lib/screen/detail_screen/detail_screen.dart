import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: getHeight(context, height: 0.3),
                  color: Colors.yellow,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: padding(context), horizontal: padding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ten nha tro",
                            style: largeTextStyle(context),
                          ),
                          spaceHeight(context, height: 0.01),
                          Text(
                            "Dia chi",
                            style: mediumTextStyle(context, color: Colors.grey),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.heart)),
                    ],
                  ),
                  spaceHeight(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gia thue tro: 100trieu/thang",
                        style: largeTextStyle(context),
                      ),
                      spaceHeight(context, height: 0.02),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 5,
                            crossAxisSpacing: getWidth(context),
                            mainAxisSpacing: getHeight(context)),
                        itemBuilder: (context, index) => ServiceWidget(
                            icon: FontAwesomeIcons.star,
                            detail: "4.1 (66 reviews)"),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: getWidth(context, width: 0.2),
                        height: getHeight(context, height: 0.1),
                        child: const CircleAvatar(
                          backgroundColor: Colors.yellow,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chu tro",
                                style: mediumTextStyle(context),
                              ),
                              Text(
                                "+8412482184",
                                style: mediumTextStyle(context),
                              )
                            ],
                          )),
                      Expanded(
                          child: Container(
                        height: getHeight(context, height: 0.07),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
