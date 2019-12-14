import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/booking/booking_page.dart';
import 'package:my_thai_star_flutter/ui/current_order/current_order_page.dart';
import 'package:my_thai_star_flutter/ui/home/home_page.dart';
import 'package:my_thai_star_flutter/ui/menu/menu_page.dart';


class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';
  static const String currentOrder = '/currentOrder';

  static Map<String, WidgetBuilder> routeMap = {
    home: (context) => HomePage(),
    booking: (context) => BookingPage(),
    menu: (context) => MenuPage(),
    currentOrder: (context) => CurrentOrderPage(),
  };
}
