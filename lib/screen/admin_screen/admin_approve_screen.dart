import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/admin_screen/navigation_draw.dart';
import 'package:flutter/material.dart';

class AdminApproveScreen extends StatefulWidget {
  const AdminApproveScreen({super.key});

  @override
  State<AdminApproveScreen> createState() => _AdminApproveScreenState();
}

class _AdminApproveScreenState extends State<AdminApproveScreen> {
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
                Padding(padding: EdgeInsets.all(4), child: Text("Chờ duyệt")),
                Padding(padding: EdgeInsets.all(4), child: Text("Đã duyệt")),
                Padding(padding: EdgeInsets.all(4), child: Text("Không duyệt")),
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
              Container(
                color: Colors.amber,
              ),
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
