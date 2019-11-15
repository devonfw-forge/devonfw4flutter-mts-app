import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/booking.dart';
import 'package:my_thai_star_flutter/ui/pages/home/home.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/menu.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/temp.dart';

class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';
  static const String temp = '/temp';

  static Map<String, WidgetBuilder> routeMap = {
    home: (context) => Home(),
    booking: (context) => Booking(),
    menu: (context) => Menu(),
    temp: (context) => Example1(),
  };
}
