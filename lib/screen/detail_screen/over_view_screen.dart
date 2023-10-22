import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/review.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key});

  @override
  State<OverViewScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            spaceWidth(context),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding(context),
                vertical: padding(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonWidget(
                      function: () {}, textButton: "Xem toan bo hinh anh"),
                  spaceHeight(context),
                  ButtonWidget(
                    function: () {
                      Navigator.pushNamed(context, Routes.detailRoute);
                    },
                    textButton: "Xem chi tiet",
                  ),
                  spaceHeight(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: mediumTextStyle(context),
                      ),
                      Text(
                        "Xem tat ca",
                        style: mediumTextStyle(context, color: Colors.blue),
                      ),
                    ],
                  ),
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ReviewWidget();
                      },
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                      itemCount: 2)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
