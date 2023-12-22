import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:app_xem_tro/models/house.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllHouseScreen extends StatelessWidget {
  const AllHouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(children: [
            spaceHeight(context),
            Center(
              child: Text("Danh sách tất cả nhà trọ",
                  style: largeTextStyle(context)),
            ),
            FutureBuilder(
                future: context.read<HouseProvider>().getAllHouse(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: getHeight(context, height: 0.4),
                              margin: EdgeInsets.only(right: padding(context)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            );
                          },
                        ));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: getHeight(context, height: 0.4),
                              margin: EdgeInsets.only(right: padding(context)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            );
                          },
                        ));
                  }
                  List<House> listHouse = snapshot.data?[1] as List<House>;
                  List<String> listDoc = snapshot.data?[0] as List<String>;
                  print(listHouse);
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
                            SizedBox(
                              height: getHeight(context, height: 0.6),
                              child: HouseItem(
                                house: listHouse[index],
                                houseId: listDoc[index],
                              ),
                            ),
                            spaceHeight(context, height: 0.02),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                      itemCount: listHouse.length);
                })
          ]),
        ),
      ),
    );
  }
}
