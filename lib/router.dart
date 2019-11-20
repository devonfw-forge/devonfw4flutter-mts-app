import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/_booking.dart';
import 'package:my_thai_star_flutter/ui/pages/current_order/_current_order.dart';
import 'package:my_thai_star_flutter/ui/pages/home/_home.dart';
import 'package:my_thai_star_flutter/ui/pages/menu/_menu.dart';
import 'package:my_thai_star_flutter/ui/pages/temp/temp.dart';

class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';
  static const String currentOrder = '/currentOrder';
  static const String temp = '/temp';

  static Map<String, WidgetBuilder> routeMap = {
    home: (context) => Home(),
    booking: (context) => Booking(),
    menu: (context) => Menu(),
    currentOrder: (context) => CurrentOrder(),
    temp: (context) => Example1(),
  };
}
