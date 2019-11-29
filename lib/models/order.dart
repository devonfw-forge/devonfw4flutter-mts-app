import 'package:my_thai_star_flutter/models/dish.dart';

class Order{
  final List<Dish> dishes;
  final String bookingCode;

  Order({this.dishes, this.bookingCode});
}