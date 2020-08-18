import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class WorldCountriesDataRow extends StatelessWidget {
  final String label;
  final int cases;
  final int todayCases;
  final bool isThereTodayCases;
  WorldCountriesDataRow(
      {this.label, this.cases, this.todayCases, this.isThereTodayCases: false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          children: <Widget>[
            Text(
              humanize.intComma(cases),
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            if (isThereTodayCases)
              Text(
                '+${humanize.intComma(todayCases)}',
                style: TextStyle(fontSize: 10, color: Colors.blueAccent),
              ),
          ],
        ),
      ],
    );
  }
}
