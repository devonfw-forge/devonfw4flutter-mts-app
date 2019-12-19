import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/booking/booking_page.dart';
import 'package:my_thai_star_flutter/ui/order/order_page.dart';
import 'package:my_thai_star_flutter/ui/home/home_page.dart';
import 'package:my_thai_star_flutter/ui/menu/menu_page.dart';
import 'package:page_transition/page_transition.dart';

///Generates a [List] of named [Route]s & gives access to the names
///
///The [Router] has a set of [String] constants that are mapped
///to the [Route]s of the Application. The [Router] also defines 
///the [PageTransition]-Animations for each [Route].
///By setting up our routes this way we don't need to define the
/// Animation every time we transition to
///a new [Route], but just once.
///
///Use the [Router] to call the [Navigator]:
///```dart
///Navigator.pushNamed(context, Router.home)
///```
class Router {
  static const String home = '/';
  static const String booking = '/booking';
  static const String menu = '/menu';
  static const String order = '/currentOrder';

  ///Generates a [List] of named [PageRoute]s
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
      case order:
        return PageTransition(
          child: OrderPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        //Returning null will map to the default PageRoute
        return null;
    }
  }
}
