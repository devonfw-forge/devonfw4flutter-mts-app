import 'package:flutter/material.dart';

final ThemeData themeData = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  final Color primary = Color.fromRGBO(62, 39, 35, 1);
  final Color accent = Color.fromRGBO(0, 102, 51, 1);
  final Color lightGray = Color.fromRGBO(224, 224, 224, 1);

  final Map<TargetPlatform, PageTransitionsBuilder> transitionMap = {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
  };

  return ThemeData(
    //Text
    textTheme: _buildDefaultTextTheme(),
    primaryTextTheme: _buildDefaultTextTheme(),
    accentTextTheme: _buildDefaultTextTheme(),
    //Colors
    primaryColor: primary,
    accentColor: accent,
    buttonColor: accent,
    backgroundColor: lightGray,
    scaffoldBackgroundColor: lightGray,
    focusColor: accent,
    //Card
    cardTheme: CardTheme(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
    ),
    //Animation
    pageTransitionsTheme: PageTransitionsTheme(builders: transitionMap),
  );
}

TextTheme _buildDefaultTextTheme() {
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
