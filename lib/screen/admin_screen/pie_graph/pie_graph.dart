import 'package:app_xem_tro/screen/admin_screen/pie_graph/pie_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieGrap extends StatelessWidget {
  const MyPieGrap({super.key, required this.bookSummary});
  final List bookSummary;

  @override
  Widget build(BuildContext context) {
    PieData pieChartData = PieData(
      book: bookSummary[0],
      cancel: bookSummary[1],
    );
    pieChartData.initializePieDataWeek();

    return PieChart(
      PieChartData(sectionsSpace: 20,startDegreeOffset: pieChartData.cancel,
        sections: pieChartData.pieData
            .map(
              (data) => PieChartSectionData(value: data.y),
            )
            .toList(),
      ),
    );
  }
}
