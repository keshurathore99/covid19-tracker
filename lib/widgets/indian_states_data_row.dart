import 'package:flutter/material.dart';
import 'package:humanize/humanize.dart' as humanize;

class IndianStateDataRow extends StatelessWidget {
  final String label;
  final int cases, todayCases;
  IndianStateDataRow(
      {@required this.label, @required this.cases, @required this.todayCases});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          humanize.intComma(cases).toString(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          ' +' + humanize.intComma(todayCases).toString(),
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}