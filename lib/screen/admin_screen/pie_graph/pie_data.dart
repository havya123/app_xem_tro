import 'package:app_xem_tro/screen/admin_screen/graph/individual_bart.dart';

class PieData {
  final double book;
  final double cancel;

  PieData({
    required this.book,
    required this.cancel,
  });

  List<IndividualBar> pieData = [];

  void initializePieDataWeek() {
    pieData = [
      IndividualBar(x: 0, y: book),
      IndividualBar(x: 1, y: cancel),
    ];
  }
}
