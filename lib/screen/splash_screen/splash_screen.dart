import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_xem_tro/route/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.loginRoute);
            },
            child: const Text("get to")),
      ),
    );
  }
}
