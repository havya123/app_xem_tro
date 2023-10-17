import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceWidget extends StatelessWidget {
  ServiceWidget({required this.icon, required this.detail, super.key});
  IconData icon;
  String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          color: Colors.yellow,
        ),
        Text(
          detail,
          style: mediumTextStyle(context),
        ),
      ],
    );
  }
}
