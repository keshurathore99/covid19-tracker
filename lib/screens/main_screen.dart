import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'india_screen.dart';
import 'world_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentItem = 0;
  List<Widget> _tabs = [
    IndiaScreen(),
    WorldScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        onTap: (int i) {
          setState(() {
            _currentItem = i;
          });
        },
        elevation: 5,
        backgroundColor: Colors.blue,
        items: [
          TabItem(
            isIconBlend: true,
            title: 'India',
            icon: Icon(
              Icons.flag,
            ),
          ),
          TabItem(
            isIconBlend: true,
            title: 'WorldWide',
            icon: Icon(Icons.info),
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            exit(0);
          },
        ),
        title: Text('Covid 19 Tracker'),
      ),
      body: _tabs[_currentItem],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
