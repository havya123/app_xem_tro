import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/booking_screen/tab_screen/tab_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> type = [
      "Accept",
      "Waiting",
      "Decline",
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            children: [
              spaceHeight(context),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Icon(FontAwesomeIcons.bell),
                ],
              ),
              spaceHeight(context),
              Text(
                'My Bookings',
                style: largeTextStyle(context, color: Colors.blue),
              ),
              TabScreen(type: type),
            ],
          ),
        ),
      ),
    );
  }
}
