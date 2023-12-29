import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: padding(context), vertical: padding(context)),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  Expanded(
                    child: Consumer<GoogleMapProvider>(
                        builder: (context, value, child) {
                      return Text(
                        "Vị trí của bạn là: ${value.currentPlace}",
                        style: smallTextStyle(context),
                      );
                    }),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.02),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.searchRoute);
                },
                child: Container(
                  width: double.infinity,
                  height: getHeight(context, height: 0.08),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        borderRadius(context, border: 0.08)),
                    color: const Color(0xffE3E3E7),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding(context)),
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
                          )
                        ]),
                  ),
                ),
              ),
              spaceHeight(context),
              Consumer<User?>(builder: (context, value, child) {
                return Text("Xin chào ${value?.name ?? ""}",
                    style: largeTextStyle(context));
              }),
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Gần bạn",
                      style: largeTextStyle(context, color: Colors.blue)),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.listHouseNearby,
                            arguments:
                                context.read<GoogleMapProvider>().currentPlace);
                      },
                      child: Text(
                        "Xem tất cả",
                        style: mediumTextStyle(context, color: Colors.blue),
                      ))
                ],
              ),
              spaceHeight(context, height: 0.02),
              FutureBuilder(
                  future: context.read<HouseProvider>().getListHouseNearBy(
                      context.read<GoogleMapProvider>().currentPlace),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: SizedBox(
                            height: getHeight(context, height: 0.5),
                            width: double.infinity,
                            child: Container(
                              margin: EdgeInsets.only(right: padding(context)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ));
                    }

                    List response = snapshot.data as List;
                    List<House> listHouse = response[0];
                    List<String> listDoc = response[1];
                    return SizedBox(
                      height: getHeight(context, height: 0.5),
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return HouseItem(
                                houseId: listDoc[index],
                                house: listHouse[index]);
                          },
                          separatorBuilder: (context, index) {
                            return spaceWidth(context);
                          },
                          itemCount:
                              listHouse.length < 5 ? listHouse.length : 5),
                    );
                  }),
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tất cả phòng trọ",
                      style: largeTextStyle(context, color: Colors.blue)),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.allHouseRoute,
                        );
                      },
                      child: Text(
                        "Xem tất cả",
                        style: mediumTextStyle(context, color: Colors.blue),
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
              spaceHeight(context),
              FutureBuilder(
                future: context.read<HouseProvider>().getAllHouse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: SizedBox(
                          height: getHeight(context, height: 0.5),
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(right: padding(context)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ));
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                  List<House> listHouse = snapshot.data![1] as List<House>;
                  List<String> listDoc = snapshot.data![0] as List<String>;
                  return SizedBox(
                    height: getHeight(context, height: 0.5),
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return HouseItem(
                              houseId: listDoc[index], house: listHouse[index]);
                        },
                        separatorBuilder: (context, index) {
                          return spaceWidth(context);
                        },
                        itemCount: listHouse.length < 5 ? listHouse.length : 5),
                  );
                },
              ),
              spaceHeight(context),
            ]),
          ),
        ),
      ),
    );
  }
}
