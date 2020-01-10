import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

///Gives the ability to mutate the current order
@immutable
abstract class CurrentOrderEvent {}

///Will add a new [OrderPostion] of the given [Dish] or
///increase the amount if a fitting [OrderPostion] already exists
@immutable
class AddDishEvent extends CurrentOrderEvent {
  final Dish dish;

  AddDishEvent(this.dish);

  @override
  String toString() => 'Add/' + dish.toString();
}

///Will decrease the amount of [Dish]es in the related [OrderPostion]
///or remove the [OrderPosition] if the amount sinks to 0
@immutable
class RemoveDishEvent extends CurrentOrderEvent {
  final Dish dish;

  RemoveDishEvent(this.dish);

  @override
  String toString() => 'Remove/' + dish.toString();
}

///Will remove one complete [OrderPosition]
@immutable
class RemoveOrderPositionEvent extends CurrentOrderEvent {
  final OrderPosition position;

  RemoveOrderPositionEvent(this.position);

  @override
  String toString() => 'DeletePos/' + position.toString();
}

@immutable
class ClearOrderEvent extends CurrentOrderEvent {
  @override
  String toString() => 'Clear';
}
