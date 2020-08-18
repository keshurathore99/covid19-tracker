import 'package:covid19tracker/screens/world_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin PieChartOfCases {
  PieChartSectionData pieChartSectionData(
      {@required int total, @required int cases, @required Color color}) {
    return PieChartSectionData(
        showTitle: true,
        titleStyle: TextStyle(color: Colors.white, fontSize: 10),
        value: WorldScreen.getPercentage(cases, total),
        title: '${WorldScreen.getPercentage(cases, total).toStringAsFixed(1)}%',
        color: color,
        radius: 30);
  }
}
