import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/screen/admin_screen/graph/bart_grap.dart';
import 'package:app_xem_tro/screen/admin_screen/navigation_draw.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<double> weeklySummary = [
    10.20,
    20.10,
    30.20,
    20.30,
    40.50,
    50.40,
    90.50
  ];
  List<double> monthlySummary = [
    10.20,
    20.10,
    30.20,
    20.30,
    40.50,
    50.40,
    60.50,
    10.20,
    20.10,
    30.20,
    20.30,
    40.50,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(234, 52, 98, 236),
        title: const Text(
          "Welcome back",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      drawer: const NavigationDraw(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(padding(context)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius(context)),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    const ComboBox(title: "User"),
                    Center(
                      child: SizedBox(
                          height: getHeight(context, height: 0.35),
                          child: MyBarGrahp(
                            weeklySummary: weeklySummary,
                            monthlySummary: monthlySummary,
                          )),
                    ),
                  ],
                ),
              ),
              spaceHeight(context),
              Container(
                padding: EdgeInsets.all(padding(context)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius(context)),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    const ComboBox(title: "LandLord"),
                    Center(
                      child: SizedBox(
                          height: getHeight(context, height: 0.35),
                          child: MyBarGrahp(
                            weeklySummary: weeklySummary,
                            monthlySummary: monthlySummary,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
