import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getHeight(context, height: 0.3),
      color: Colors.yellow,
    );
  }
}
