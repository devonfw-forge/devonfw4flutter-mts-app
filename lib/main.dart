import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/router.dart';
void main() => runApp(MyThaiStar());

class MyThaiStar extends StatelessWidget {
  final ThemeData themeData = ThemeData(
    primaryColor: Color.fromRGBO(62, 39, 35, 1),
    accentColor: Color.fromRGBO(0, 102, 51, 1),
    backgroundColor: Color.fromRGBO(224, 224, 224, 1),
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
      button: TextStyle(fontSize: 14, color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Thai Star',
      theme: themeData,
      initialRoute: Router.home,
      routes: Router.routeMap,
    );
  }
}
