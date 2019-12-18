import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/booking/booking_page.dart';
import 'package:my_thai_star_flutter/ui/current_order/current_order_page.dart';
import 'package:my_thai_star_flutter/ui/home/home_page.dart';
import 'package:my_thai_star_flutter/ui/menu/menu_page.dart';
import 'package:page_transition/page_transition.dart';

class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';
  static const String currentOrder = '/currentOrder';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case booking:
        return PageTransition(
          child: BookingPage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case menu:
        return PageTransition(
          child: MenuPage(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case currentOrder:
        return PageTransition(
          child: CurrentOrderPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        return null;
    }
  }
}
