import 'package:app_xem_tro/route/route_manager.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppXemTro extends StatefulWidget {
  const AppXemTro({super.key});

  @override
  State<AppXemTro> createState() => _AppXemTroState();
}

class _AppXemTroState extends State<AppXemTro> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      getPages: RouteManager.routeManager,
      unknownRoute: RouteManager.notFound,
    );
  }
}
