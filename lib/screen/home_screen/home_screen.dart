import 'package:app_xem_tro/config/size_config.dart';
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
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
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
                const Text(
                  "Bành chính",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                )
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
                      const Text(
                        "Tìm địa điểm",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      )
                    ]),
              ),
            ),
            spaceHeight(context),
            const Text(
              "Welcome to ...",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            spaceHeight(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Gần bạn",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ))
              ],
            ),
            spaceHeight(context, height: 0.02),
            SizedBox(
              height: getHeight(context, height: 0.4),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.circular(borderRadius(context))),
                      ),
                    );
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
                const Text(
                  "Top đánh giá ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ))
              ],
            ),
            spaceHeight(context, height: 0.02),
            SizedBox(
              height: getHeight(context, height: 0.4),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.circular(borderRadius(context))),
                      ),
                    );
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
