import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
class OrderPosition extends Equatable {
  final Dish dish;
  final int amount;
  final double price;

  OrderPosition({this.dish, this.amount}) : price = _getPrice(dish, amount);

  @override
  List<Object> get props => [dish, amount];

  @override String toString() => "${amount.toString()} ${dish.name}";

  static double _getPrice(Dish dish, int amount) => dish.price * amount;

  String get formattedPrice => price.toStringAsFixed(2);

  OrderPosition copyWith({
    Dish dish,
    int amount,
  }) =>
      OrderPosition(
        dish: dish ?? this.dish,
        amount: amount ?? this.amount,
      );
}
