import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/firebase_service/firebase.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:app_xem_tro/screen/save_screen/save_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool isNotReady = true;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final googleMapProvider = context.read<GoogleMapProvider>();
    final houseProvider = context.read<HouseProvider>();
    final favouriteProvider = context.read<FavouriteProvider>();
    final userLoginProvider = context.read<UserLoginProvider>();
    final bookingProvider = context.read<BookingProvider>();

    await Future.wait([
      googleMapProvider.initPlace(),
      favouriteProvider.loadWatchList(userLoginProvider.userPhone),
    ]);

    await houseProvider.getListHouseNearBy(googleMapProvider.currentPlace);
    await bookingProvider.getListBookingUser(userLoginProvider.userPhone);

    isNotReady = false;
  }

  @override
  Widget build(BuildContext context) {
    final PersistentTabController controller = PersistentTabController();
    List<Widget> widgets = [
      const HomeScreen(),
      const SaveScreen(),
      const ListChatScreen(),
      ProfileScreen(controller: controller),
    ];

    List<PersistentBottomNavBarItem> barItem = [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home), inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.heart,
          ),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.message),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person), inactiveColorPrimary: Colors.black),
    ];

    return Consumer<UserLoginProvider>(
      builder: (context, value, child) {
        if (value.userPhone.isEmpty) {
          return const LoginScreen();
        }
        return PersistentTabView(
          controller: controller,
          context,
          screens: widgets,
          items: barItem,
          decoration: NavBarDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(
              borderRadius(context),
            ),
          ),
        );
      },
    );
  }
}
