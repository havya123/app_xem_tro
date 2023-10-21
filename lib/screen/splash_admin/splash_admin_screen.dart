import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:get/get.dart';

class SplashScreenAdmin extends StatelessWidget {
  const SplashScreenAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: getHeight(context, height: 0.4),
              width: getWidth(context, width: 0.9),
              child: Image.asset(
                'assets/images/splash_img/splash_icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          spaceHeight(context, height: 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getHeight(context, height: 0.05)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to ', style: largeTextStyle(context, size: 0.05)),
                spaceHeight(context, height: 0.01),
                Text(
                  'Admin',
                  style: largeTextStyle(context, size: 0.05),
                ),
                spaceHeight(context, height: 0.03),
                Text(
                    'Find the tenant, list your property in just a simple stepts, in your hand.',
                    style: smallTextStyle(context, size: 0.02)),
                spaceHeight(context, height: 0.03),
                Text('You are one step away.',
                    style: smallTextStyle(context, size: 0.02)),
                spaceHeight(context, height: 0.10),
                ButtonWidget(
                  function: () {
                    Get.toNamed(Routes.splashadminRoute);
                  },
                  textButton: "Get Started",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
