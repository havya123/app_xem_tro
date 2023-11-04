import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';

class ListRoom extends StatelessWidget {
  const ListRoom({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding(context),
            vertical: padding(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vị trí hiện tại',
                  style: mediumTextStyle(context),
                ),
                spaceHeight(context, height: 0.02),
                Row(
                  children: [
                    SizedBox(
                      height: getHeight(context, height: 0.06),
                      width: getWidth(context, width: 0.06),
                      child: Image.asset(
                        "assets/images/home_img/location.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    spaceWidth(context),
                    Text("Bành chính", style: largeTextStyle(context))
                  ],
                ),
                spaceHeight(context, height: 0.02),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        height: getHeight(context, height: 0.08),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              borderRadius(context, border: 0.08)),
                          color: const Color(0xffE3E3E7),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding(context)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: getHeight(context, height: 0.05),
                                width: getWidth(context, width: 0.05),
                                child: Image.asset(
                                  "assets/images/home_img/search.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              spaceWidth(context, width: 0.04),
                              Text(
                                "Tìm địa điểm",
                                style: mediumTextStyle(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.add_road_sharp),
                    )
                  ],
                ),
                spaceHeight(context, height: 0.02),
                Text(
                  'Danh sách phòng trọ của bạn',
                  style: largeTextStyle(context),
                ),
                SizedBox(
                  height: getHeight(context, height: 0.05),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Thêm phòng trọ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    spaceWidth(context, width: 0.03),
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(Routes.searchRoute);
                      },
                      child: const Icon(
                        Icons.add_alarm,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Phòng trọ 1',
                      style: mediumTextStyle(
                        context,
                      ),
                    ),
                  ],
                ),
                spaceHeight(context, height: 0.02),
                SizedBox(
                  height: getHeight(context, height: 0.2),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const Item();
                      },
                      separatorBuilder: (context, index) {
                        return spaceWidth(context);
                      },
                      itemCount: 5),
                ),
                spaceHeight(context, height: 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Phòng trọ 2',
                      style: mediumTextStyle(
                        context,
                      ),
                    ),
                  ],
                ),
                spaceHeight(context, height: 0.02),
                SizedBox(
                  height: getHeight(context, height: 0.2),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const Item();
                      },
                      separatorBuilder: (context, index) {
                        return spaceWidth(context);
                      },
                      itemCount: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
