import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (context.read<UserLoginProvider>().userPhone == "") {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.loginRoute);
      });
      return;
    }
    bool tokenExpired =
        await context.read<UserLoginProvider>().checkTokenExpired();
    if (tokenExpired == false) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamed(Routes.loginRoute);
      });
      return;
    }
    if (await checkRole() == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamed(Routes.navigationRoute);
      });
      return;
    }
    Get.offNamed(Routes.navigationListHouseRoute);
  }

  Future<int> checkRole() async {
    int role = await context.read<UserLoginProvider>().checkRole();
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
