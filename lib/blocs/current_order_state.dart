import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

///Describes the state of the current order
///
///The current order consists of a list of [OrderPositions].
///The total amount of [Dish]es and the total price are calculated
///on creation of the [CurrentOrderState].
///
///#### Why OrderPosions?
///We use [OrderPosition]s and just a [List<Dish>] because that is closer
///to the front-end representation in the [OrderPage]. If we had a [List<Dish>]
///we would need to do a lot of formatting in the UI which is against
///the Bloc-pattern.
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

  String get formattedTotalPrice => totalPrice.toStringAsFixed(2) + ' €';
}

@immutable
class InitialCurrentOrderState extends CurrentOrderState {
  InitialCurrentOrderState() : super(List());

  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Initial';
}

///Describes the default state of the [CurrentOrderBloc] after initialization
@immutable
class IdleCurrentOrderState extends CurrentOrderState {
  IdleCurrentOrderState(List<OrderPosition> positions) : super(positions);

  @override
  List<Object> get props => [positions, numberOfDishes, totalPrice];

  @override
  String toString() => 'Idle/NumberOfDishes: ' + numberOfDishes.toString();
}
