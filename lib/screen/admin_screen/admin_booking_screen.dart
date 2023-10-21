import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:app_xem_tro/screen/admin_screen/navigation_draw.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminBookingScreen extends StatefulWidget {
  const AdminBookingScreen({super.key});

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  late List<BookingData> _chartData;

  @override
  void initState() {
    _chartData = getCharData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: const Color.fromARGB(234, 52, 98, 236),
    //     title: const Text(
    //       "Welcome back",
    //       style: TextStyle(
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   drawer: const NavigationDraw(),
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.all(padding(context)),
    //       child: Center(
    //         heightFactor: getHeight(context, height: 0.00225),
    //         child: Column(
    //           children: [
    //             Container(
    //               padding: EdgeInsets.all(padding(context)),
    //               decoration: BoxDecoration(
    //                   borderRadius:
    //                       BorderRadius.circular(borderRadius(context)),
    //                   border: Border.all(color: Colors.black)),
    //               child: Column(
    //                 children: [
    //                   const ComboBox(title: "User"),
    //                   Center(
    //                     child: SizedBox(
    //                         height: getHeight(context, height: 0.35),
    //                         child: MyPieGrap(
    //                           bookSummary: bookSummary,
    //                         )),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
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
          child: Padding(
            padding: EdgeInsets.all(padding(context)),
            child: Center(
              heightFactor: getHeight(context, height: 0.00225),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(borderRadius(context)),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        const ComboBox(title: "User"),
                        SfCircularChart(
                          legend: const Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              position: LegendPosition.right,
                              textStyle: TextStyle(fontSize: 20)),
                          series: <CircularSeries>[
                            RadialBarSeries<BookingData, String>(
                              dataSource: _chartData,
                              yValueMapper: (BookingData data, _) => data.count,
                              xValueMapper: (BookingData data, _) => data.book,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true,),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BookingData> getCharData() {
    final List<BookingData> chartData = [
      BookingData("Cancel", 120),
      BookingData("Booking", 80),
    ];
    return chartData;
  }
}

class BookingData {
  final String book;
  final int count;

  BookingData(this.book, this.count);
}
