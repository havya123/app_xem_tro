import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/room_register_provider.dart';
import 'package:app_xem_tro/provider/search_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/route_manager.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class AppXemTro extends StatelessWidget {
  const AppXemTro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initUserLoginProvider(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => snapshot.data as UserLoginProvider),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => GoogleMapProvider()),
            ChangeNotifierProvider(create: (context) => HouseProvider()),
            ChangeNotifierProvider(create: (context) => RoomRegisterProvider()),
            ChangeNotifierProvider(create: (context) => FavouriteProvider()),
            ChangeNotifierProvider(create: (context) => MessageProvider()),
            ChangeNotifierProvider(create: (context) => BookingProvider()),
            ChangeNotifierProvider(create: (context) => SearchProvider()),
          ],
          builder: (context, child) {
            final userLoginProvider = context.watch<UserLoginProvider>();
            if (userLoginProvider.userPhone.isEmpty) {
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
                  .doc(userLoginProvider.userPhone)
                  .snapshots()
                  .map((event) {
                return event.data();
              }),
              builder: (context, snapshot) {
                return Consumer<User?>(builder: (context, value, child) {
                  if (value?.role == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (value!.role == 0) {
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      initialRoute: Routes.navigationRoute,
                      getPages: RouteManager.routeManager,
                      unknownRoute: RouteManager.notFound,
                    );
                  }
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: Routes.navigationListHouseRoute,
                    getPages: RouteManager.routeManager,
                    unknownRoute: RouteManager.notFound,
                  );
                });
              },
            );
          },
        );
      },
    );
  }

  Future<UserLoginProvider> _initUserLoginProvider(BuildContext context) async {
    final userLoginProvider = UserLoginProvider();
    await userLoginProvider.readPhoneNumber();
    return userLoginProvider;
  }
}
