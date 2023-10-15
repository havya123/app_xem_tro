import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: padding(context), vertical: padding(context)),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Vị trí hiện tại",
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
            Container(
              width: double.infinity,
              height: getHeight(context, height: 0.08),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(borderRadius(context, border: 0.08)),
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
            spaceHeight(context),
            Text("Welcome to ...", style: largeTextStyle(context)),
            spaceHeight(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gần bạn", style: largeTextStyle(context)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Xem tất cả",
                      style: mediumTextStyle(context, color: Colors.blue),
                    ))
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
            spaceHeight(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top đánh giá ",
                  style: largeTextStyle(context),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Xem tất cả",
                      style: mediumTextStyle(context, color: Colors.blue),
                    ))
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
          ]),
        ),
      ),
    );
  }
}
