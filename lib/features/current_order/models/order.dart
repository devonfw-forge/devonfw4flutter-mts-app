import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:my_thai_star_flutter/features/menu/models/dish.dart';

class Order {
  final LinkedHashMap<Dish, int> dishes;
  final String bookingCode;

  Order({
    @required this.dishes,
    @required this.bookingCode,
  });
}
