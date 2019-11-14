import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/booking.dart';
import 'package:my_thai_star_flutter/ui/pages/home/home.dart';

class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> routeMap = {
    home: (context) => Home(),
    booking: (context) => Booking(),
    //menu: (context) => AltTabCard(),
  };
}
