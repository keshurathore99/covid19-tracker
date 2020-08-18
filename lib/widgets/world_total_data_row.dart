import 'package:flutter/material.dart';

class WorldTotalDataRow extends StatelessWidget {
  final int totalCases, todayCases;
  final double showIcon;
  final Color iconColor;
  final String label;
  final bool isThereTodayCases;

  WorldTotalDataRow(
      {@required this.totalCases,
      @required this.label,
      this.showIcon: 0,
      this.todayCases,
      this.iconColor,
      this.isThereTodayCases: false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$label : $totalCases',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        if(isThereTodayCases)
        Text(
          '+${todayCases.toString()}',
          style: TextStyle(fontSize: 10, color: Colors.blueAccent),
        ),
        Opacity(
            opacity: showIcon,
            child: Icon(
              Icons.stop,
              size: 18,
              color: iconColor,
            )),
      ],
    );
  }
}
