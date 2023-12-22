import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/provider/booking_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:app_xem_tro/screen/listhouse_screen/listhouse_screen.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class NavigationListHouseScreen extends StatefulWidget {
  const NavigationListHouseScreen({super.key});

  @override
  State<NavigationListHouseScreen> createState() =>
      _NavigationListHouseScreenState();
}

class _NavigationListHouseScreenState extends State<NavigationListHouseScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    await context
        .read<BookingProvider>()
        .getListBookingLandlord(context.read<UserLoginProvider>().userPhone);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const ListHouse(),
      const ListChatScreen(),
      ProfileScreen(),
    ];
    List<PersistentBottomNavBarItem> barlistItem = [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home), inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.message),
          inactiveColorPrimary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person), inactiveColorPrimary: Colors.black),
    ];
    return Consumer<UserLoginProvider>(builder: (context, value, child) {
      if (value.userPhone.isEmpty) {
        return const LoginScreen();
      }
      return PersistentTabView(
        context,
        screens: widgets,
        items: barlistItem,
        decoration: NavBarDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(
            borderRadius(context),
          ),
        ),
      );
    });
  }
}
