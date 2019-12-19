import 'package:flutter/material.dart';

///Defines the global [Theme] of the App
///
///Will only be accessed once on initialization
///of the [MaterialApp]. Because we define a global theme once, 
///we don't need to set the style of every Widget in the app
///manually.
class MtsTheme {
  static const Color _primary = Color.fromRGBO(62, 39, 35, 1);
  static const Color _accent = Color.fromRGBO(0, 102, 51, 1);
  static const Color _lightGray = Color.fromRGBO(224, 224, 224, 1);

  static ThemeData get() {
    return ThemeData(
      //Text
      textTheme: _buildDefaultTextTheme(),
      primaryTextTheme: _buildDefaultTextTheme(),
      accentTextTheme: _buildDefaultTextTheme(),
      //Colors
      primaryColor: _primary,
      accentColor: _accent,
      buttonColor: _accent,
      backgroundColor: _lightGray,
      scaffoldBackgroundColor: _lightGray,
      focusColor: _accent,
      //Card
      cardTheme: CardTheme(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  static TextTheme _buildDefaultTextTheme() {
    return TextTheme(
      headline: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      title: TextStyle(
        fontSize: 18.0,
      ),
      subtitle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      body1: TextStyle(
        fontSize: 14.0,
      ),
      button: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      caption: TextStyle(
        fontSize: 12.0,
      ),
    );
  }
}
