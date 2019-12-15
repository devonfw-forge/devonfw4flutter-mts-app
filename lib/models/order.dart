import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
class Order extends Equatable {
  final LinkedHashMap<Dish, int> dishes;
  final String bookingCode;

  Order({@required this.dishes, @required this.bookingCode});

  @override
  List<Object> get props => [dishes, bookingCode];
}
