import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/admin_screen/navigation_draw.dart';
import 'package:flutter/material.dart';

class AdminAccountScreen extends StatefulWidget {
  const AdminAccountScreen({super.key});

  @override
  State<AdminAccountScreen> createState() => _AdminAccountScreenState();
}

class _AdminAccountScreenState extends State<AdminAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getHeight(context, height: 0.1)),
          child: AppBar(
            title: const Text("Welcome back"),
            bottom: const TabBar(
              tabs: [
                Padding(padding: EdgeInsets.all(8), child: Text("Người dùng")),
                Padding(padding: EdgeInsets.all(8), child: Text("Chủ trọ")),
                Padding(padding: EdgeInsets.all(8), child: Text("Blacklist")),
              ],
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white,
            ),
          ),
        ),
        drawer: const NavigationDraw(),
        body: SafeArea(
          child: TabBarView(
            children: [
              Container(),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
