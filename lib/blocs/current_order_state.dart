import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

@immutable
abstract class CurrentOrderState implements Equatable {
  final List<OrderPosition> positions;

  CurrentOrderState(this.positions);

  int get numberOfDishes {
    int amount = 0;
    positions.forEach((pos) => amount += pos.amount);
    return amount;
  }

  double get totalPrice {
    double price = 0;
    positions.forEach((position) => price += position.price);
    return price;
  }

  String get formattedTotalPrice => totalPrice.toStringAsFixed(2);
}

@immutable
class InitialCurrentOrderState extends CurrentOrderState {
  InitialCurrentOrderState() : super(List());

  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial';
}

@immutable
class IdleCurrentOrderState extends CurrentOrderState {
  IdleCurrentOrderState(List<OrderPosition> positions) : super(positions);

  @override
  List<Object> get props => [positions, numberOfDishes, totalPrice];

  @override
  String toString() => 'Idle/NumberOfDishes: ' + numberOfDishes.toString();
}
