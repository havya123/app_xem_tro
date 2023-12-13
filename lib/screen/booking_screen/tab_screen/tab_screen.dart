import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/booking_screen/tab_widget/tab_widget.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  TabScreen({required this.type, this.widget, super.key});
  List<String> type;
  Widget? widget;
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.type.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: const Color(0xff3A3F47),
            indicatorWeight: 4.0,
            unselectedLabelStyle: mediumTextStyle(context),
            labelStyle: largeTextStyle(context),
            isScrollable: true,
            tabs: widget.type.map((tab) => Tab(text: tab)).toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          spaceHeight(context),
          TabWidget(indexTab: _currentIndex),
        ],
      ),
    );
  }
}
