import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacilityWidget extends StatefulWidget {
  FacilityWidget({required this.facility, super.key});

  String facility;

  @override
  State<FacilityWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FacilityWidget> {
  Widget? icon;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    if (widget.facility == "Cửa hàng") {
      icon = const Icon(FontAwesomeIcons.store);
      return;
    }
    if (widget.facility == "Tiệm giặt") {
      icon = Image.asset(
        "assets/icons/washing-machine.png",
        fit: BoxFit.cover,
      );
      return;
    }
    if (widget.facility == "Chợ") {
      icon = Image.asset("assets/icons/market.png", fit: BoxFit.cover);
      return;
    }
    if (widget.facility == "Cafe") {
      icon = const Icon(FontAwesomeIcons.mugSaucer);
      return;
    }
    if (widget.facility == "Giữ xe") {
      icon = const Icon(FontAwesomeIcons.squareParking);
      return;
    }
    if (widget.facility == "Nội thất") {
      icon = Image.asset("assets/icons/interior-design.png", fit: BoxFit.cover);
      return;
    }
    if (widget.facility == "Wifi") {
      icon = const Icon(FontAwesomeIcons.wifi);
      return;
    }
    if (widget.facility == "Máy lạnh") {
      icon =
          Image.asset("assets/icons/air-conditioning.png", fit: BoxFit.cover);
      return;
    }
    icon = const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context, width: 0.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffEFF4FC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spaceHeight(context),
          Expanded(flex: 1, child: icon as Widget),
          spaceHeight(context),
          Expanded(flex: 1, child: Text(widget.facility)),
        ],
      ),
    );
  }
}
