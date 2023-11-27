import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/listroom_screen/listroom_screen.dart';
import 'package:app_xem_tro/screen/profile_screen/profie_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationListRoomScreen extends StatelessWidget {
  const NavigationListRoomScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const ListRoom(),
      const ChatScreen(),
      ProfileScreen(),
    ];
    List<PersistentBottomNavBarItem> barlistRoomItem = [
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
      items: barlistRoomItem,
      decoration: NavBarDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(
          borderRadius(context),
        ),
      ),
    );
  }
}
