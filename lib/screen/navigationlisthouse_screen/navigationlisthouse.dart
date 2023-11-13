import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/listhouse_screen/listhouse_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationListHouseScreen extends StatelessWidget {
  const NavigationListHouseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const ListHouse(),
      const ChatScreen(),
      const ProfileScreen(),
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
  }
}