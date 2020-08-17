import 'package:flutter/material.dart';

class IndiaTotalDataRow extends StatelessWidget {
  final String label;
  final cases;
  final Color iconColor;
  final double showIcon;

  IndiaTotalDataRow(
      {@required this.label,
      @required this.cases,
      this.iconColor: Colors.red,
      this.showIcon: 1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            '$label : ',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Text(cases.toString(),
            style: TextStyle(fontWeight: FontWeight.w600)),
        Opacity(
          opacity: showIcon,
          child: Icon(
            Icons.stop,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
