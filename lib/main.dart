import 'package:covid19tracker/screens/WorldScreen.dart';
import 'package:flutter/material.dart';
import 'screens/IndiaScreen.dart';

import 'screens/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        IndiaScreen.routeName: (context) => IndiaScreen(),
        MainScreen.routeName: (context) => MainScreen(),
        WorldScreen.routeName: (context) => WorldScreen(),
      },
    );
  }
}
