import 'package:flutter/material.dart';

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
          cases.toString(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          ' +' + todayCases.toString(),
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}