import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/route_manager.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/foundation.dart';
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
        ChangeNotifierProvider(
            create: (context) => UserLoginProvider()..readPhoneNumber()),
        ChangeNotifierProvider(create: (context) => GoogleMapProvider()),
        ChangeNotifierProvider(create: (context) => HouseProvider()),
        ChangeNotifierProvider(create: (context) => RoomRegisterProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
        ChangeNotifierProvider(create: (context) => MessageProvider())
      ],
      builder: (context, child) {
        return Consumer<UserLoginProvider>(builder: (context, value, chid) {
          if (value.userPhone.isEmpty) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splashRoute,
              getPages: RouteManager.routeManager,
              unknownRoute: RouteManager.notFound,
            );
          }
          return StreamProvider<User?>.value(
              initialData: null,
              value: FirebaseService.userRef
                  .doc(value.userPhone)
                  .snapshots()
                  .map((event) {
                return event.data();
              }),
              builder: (contexts, snapshot) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: Routes.navigationRoute,
                  getPages: RouteManager.routeManager,
                  unknownRoute: RouteManager.notFound,
                );
              });
        });
      },
    );
  }
}
