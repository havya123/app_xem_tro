import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({required this.icon, required this.detail, super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Icon(
            icon,
            color: Colors.yellow,
          ),
        ),
        spaceWidth(context),
        Expanded(
          child: Text(
            detail,
            style: mediumTextStyle(context),
          ),
        ),
      ],
    );
  }
}
