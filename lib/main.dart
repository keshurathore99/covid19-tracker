import 'package:covid19tracker/screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'screens/india_screen.dart';

import 'screens/main_screen.dart';

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
