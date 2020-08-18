import 'package:flutter/material.dart';

class LoadingBarForTotalData extends StatelessWidget {
  final int expandedFlex;
  LoadingBarForTotalData({@required this.expandedFlex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: expandedFlex,
        child: Container(
          child: Card(
            child: Center(
              child: Text('Loading Please Wait...'),
            ),
          ),
        ));
  }
}
