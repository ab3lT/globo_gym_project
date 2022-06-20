import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineCharWidget extends StatelessWidget {
  const LineCharWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        // titlesData: LineTitles.getTitleData(),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 8,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 2.5),
              FlSpot(2, 2),
              FlSpot(4, 3),
              FlSpot(6, 2.5),
              FlSpot(8, 4),
              FlSpot(10, 3),
              FlSpot(12, 4.5),
            ],
            color: Colors.white70,
            barWidth: 3,
          )
        ]));
  }
}
