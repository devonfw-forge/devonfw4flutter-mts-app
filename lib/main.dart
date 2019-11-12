import 'package:flutter/material.dart';

import 'ui/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ThemeData themeData = ThemeData(
    primaryColor: Color.fromRGBO(62, 39, 35, 1),
    accentColor: Color.fromRGBO(0, 102, 51, 1),
    textTheme: TextTheme(
      headline: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      title: TextStyle(fontSize: 18),
      subtitle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      body1: TextStyle(fontSize: 14),
      caption: TextStyle(fontSize: 12),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Thai Star',
      theme: themeData,
      home: Home(),
    );
  }
}
