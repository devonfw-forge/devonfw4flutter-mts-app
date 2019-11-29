import 'dart:collection';

import 'package:my_thai_star_flutter/models/dish.dart';

class Order{
  final LinkedHashMap<Dish, int> dishes;
  final String bookingCode;

  Order({this.dishes, this.bookingCode});
}