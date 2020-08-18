import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class WorldTotalDataRow extends StatelessWidget {
  final int totalCases, todayCases;
  final String label;
  final bool isThereTodayCases;
  final double showIcon;
  final Color iconColor, todayCasesTextColor;

  WorldTotalDataRow(
      {@required this.totalCases,
      @required this.label,
      this.todayCases,
      this.isThereTodayCases: false,
      this.showIcon: 0,
      this.iconColor: Colors.black,
      this.todayCasesTextColor: Colors.blueAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FittedBox(
            child: Text(
              '$label : ${humanize.intComma(totalCases)}',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (isThereTodayCases)
            Text(
              '+${todayCases.toString()}',
              style: TextStyle(fontSize: 10, color: todayCasesTextColor),
            ),
          Opacity(
              opacity: showIcon,
              child: Icon(
                Icons.stop,
                size: 18,
                color: iconColor,
              )),
        ],
      ),
    );
  }
}
