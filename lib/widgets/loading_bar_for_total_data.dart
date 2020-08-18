import 'package:flutter/material.dart';

class LoadingBarForTotalData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          child: Card(
            child: Center(
              child: Text('Loading Please Wait...'),
            ),
          ),
        ));
  }
}
