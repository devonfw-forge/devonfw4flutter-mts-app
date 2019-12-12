import 'package:flutter/material.dart';

final ThemeData themeData = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  final ThemeData base = ThemeData.light();

  final Color primary = Color.fromRGBO(62, 39, 35, 1);
  final Color accent = Color.fromRGBO(0, 102, 51, 1);
  final Color lightGray = Color.fromRGBO(224, 224, 224, 1);

  final Map<TargetPlatform, PageTransitionsBuilder> transitionMap ={
    TargetPlatform.android : CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS : CupertinoPageTransitionsBuilder()
  };

  return base.copyWith(
    //Text
    textTheme: _buildDefaultTextTheme(base.textTheme),
    primaryTextTheme: _buildDefaultTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildDefaultTextTheme(base.accentTextTheme),
    //Colors
    primaryColor: primary,
    accentColor: accent,
    buttonColor: accent,
    backgroundColor: lightGray,
    scaffoldBackgroundColor: lightGray,
    focusColor: accent,
    highlightColor: accent,
    splashColor: accent,
    disabledColor: Colors.grey,
    //Card
    cardTheme: CardTheme(
      elevation: 2.0,
      margin: EdgeInsets.all(20.0),
      clipBehavior: Clip.antiAlias,
    ),
    //Animation
   pageTransitionsTheme: PageTransitionsTheme(builders: transitionMap),
  );
}

TextTheme _buildDefaultTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    title: base.title.copyWith(
      fontSize: 18.0,
    ),
    subtitle: base.subtitle.copyWith(
      fontSize: 16,
      color: Colors.white,
    ),
    body1: base.body1.copyWith(
      fontSize: 14.0,
    ),
    button: base.button.copyWith(
      fontSize: 14,
      color: Colors.white,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    ),
  );
}
