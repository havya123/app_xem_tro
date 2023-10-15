import 'package:app_xem_tro/config/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:get/get.dart';

import '../../config/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to ',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                spaceHeight(context, height: 0.01),
                const Text(
                  'RenTaXo',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                spaceHeight(context, height: 0.03),
                const Text(
                  'Find the tenant, list your property in just a simple stepts, in your hand.',
                  style: TextStyle(fontSize: 15),
                ),
                spaceHeight(context, height: 0.03),
                const Text(
                  'You are one step away.',
                  style: TextStyle(fontSize: 15),
                ),
                spaceHeight(context, height: 0.10),
                ButtonWidget(
                  function: () {
                    Get.toNamed(Routes.loginRoute);
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
