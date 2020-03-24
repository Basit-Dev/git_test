//Utility App

import 'package:flutter/material.dart';
import 'homePage.dart';



void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.blue,
      ),
      title: _title,
      home: HomePage(
      ),
    );
  }
}
