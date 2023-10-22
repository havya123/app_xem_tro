import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/admin_screen/graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGrahp extends StatelessWidget {
  const MyBarGrahp({super.key, this.weeklySummary, this.monthlySummary});
  final List? weeklySummary;
  final List? monthlySummary;
  @override
  Widget build(BuildContext context) {
    BarDataWeek myBarDataWeek = BarDataWeek(
      sunAmount: weeklySummary?[0],
      monAmount: weeklySummary?[1],
      tueAmount: weeklySummary?[2],
      wedAmount: weeklySummary?[3],
      thurAmount: weeklySummary?[4],
      friAmount: weeklySummary?[5],
      satAmount: weeklySummary?[6],
    );
    myBarDataWeek.initializeBarDataWeek();
    BarDataMonth myBarDataMonth = BarDataMonth(
        janAmount: monthlySummary?[0],
        febAmount: monthlySummary?[1],
        marAmount: monthlySummary?[2],
        aprAmount: monthlySummary?[3],
        mayAmount: monthlySummary?[4],
        junAmount: monthlySummary?[5],
        julAmount: monthlySummary?[6],
        augAmount: monthlySummary?[7],
        sepAmount: monthlySummary?[8],
        octAmount: monthlySummary?[9],
        novAmount: monthlySummary?[10],
        decAmount: monthlySummary?[11]);
    myBarDataMonth.initializeBarDataMonth();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
            show: true,
            border: const Border(
              top: BorderSide.none,
              bottom: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide.none,
            )),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  interval: 50,
                  reservedSize: getWidth(context, width: 0.085))),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: const AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTiles)),
        ),
        barGroups: myBarDataWeek.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.blue,
                    borderRadius: BorderRadius.zero,
                    width: getWidth(context),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("Su");
      break;
    case 1:
      text = const Text("Mo");
      break;
    case 2:
      text = const Text("Th");
      break;
    case 3:
      text = const Text("We");
      break;
    case 4:
      text = const Text("Th");
      break;
    case 5:
      text = const Text("Fr");
      break;
    case 6:
      text = const Text("Sa");
      break;
    default:
      text = const Text("");
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
