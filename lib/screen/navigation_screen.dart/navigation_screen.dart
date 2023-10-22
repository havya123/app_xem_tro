import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/home_screen/home_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:app_xem_tro/screen/save_screen/save_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const HomeScreen(),
      const SaveScreen(),
      const ChatScreen(),
      const ProfileScreen(),
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

    return PersistentTabView(
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
  }
}
