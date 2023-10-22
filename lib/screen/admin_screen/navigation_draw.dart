import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationDraw extends StatelessWidget {
  const NavigationDraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.all(padding(context)),
            child: const Text(
              "Admin",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ButtonListTile(
          title: "Register",
          icon: FontAwesomeIcons.book,
          onPress: () {
            Navigator.pushReplacementNamed(context, Routes.adminRoute);
          },
        ),
        ButtonListTile(
          title: 'Account',
          icon: FontAwesomeIcons.user,
          onPress: () {
            Navigator.pushReplacementNamed(context, Routes.adminAccountRoute);
          },
        ),
        spaceHeight(context, height: 0.01),
        ButtonListTile(
          title: 'Booking',
          icon: FontAwesomeIcons.calendarCheck,
          onPress: () {
            Navigator.pushReplacementNamed(context, Routes.adminBookingRoute);
          },
        ),
        ButtonListTile(
          title: 'Approve',
          icon: FontAwesomeIcons.clipboardCheck,
          onPress: () {
            Navigator.pushReplacementNamed(context, Routes.adminApproveRoute);
          },
        ),
      ],
    );
  }
}
