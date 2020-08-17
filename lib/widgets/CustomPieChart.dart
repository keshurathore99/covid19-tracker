import 'package:covid19tracker/screens/WorldScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(borderData: FlBorderData(show: false), sections: [
        PieChartSectionData(
            showTitle: true,
            titleStyle: TextStyle(color: Colors.white, fontSize: 10),
            value: WorldScreen.getPercentage(12, 1212),
            title:
                '${WorldScreen.getPercentage(12, 1212).toStringAsFixed(1)}%',
            color: Colors.blueAccent,
            radius: 30),
        PieChartSectionData(
            showTitle: true,
            value: WorldScreen.getPercentage(12, 1212),
            title:
                '${WorldScreen.getPercentage(12, 1212).toStringAsFixed(1)}%',
            titleStyle: TextStyle(fontSize: 10, color: Colors.white),
            color: Colors.green,
            radius: 30),
        PieChartSectionData(
            showTitle: true,
            titleStyle: TextStyle(color: Colors.white, fontSize: 10),
            value: WorldScreen.getPercentage(12, 1212),
            title:
                '${WorldScreen.getPercentage(12, 1212).toStringAsFixed(1)}%',
            color: Colors.red,
            radius: 30),
      ]),
    );
  }
}
