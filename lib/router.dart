import 'package:flutter/cupertino.dart';
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

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case booking:
        return MaterialPageRoute(builder: (_) => BookingPage());
      case menu:
        return MaterialPageRoute(builder: (_) => MenuPage());
      case currentOrder:
        return CupertinoPageRoute(builder: (_) => CurrentOrderPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
