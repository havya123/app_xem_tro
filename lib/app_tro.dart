import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/route_manager.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class AppXemTro extends StatefulWidget {
  const AppXemTro({super.key});

  @override
  State<AppXemTro> createState() => _AppXemTroState();
}

class _AppXemTroState extends State<AppXemTro> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
        ChangeNotifierProvider(create: (context) => GoogleMapProvider()),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.signupRoute,
          getPages: RouteManager.routeManager,
          unknownRoute: RouteManager.notFound,
        );
      },
    );
  }
}
