import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

@immutable
abstract class CurrentOrderEvent extends Equatable {}

@immutable
class AddDishEvent extends CurrentOrderEvent {
  final Dish dish;

  AddDishEvent(this.dish);

  @override
  List<Object> get props => [dish];

  @override
  String toString() => 'Add/' + dish.toString();
}

@immutable
class RemoveDishEvent extends CurrentOrderEvent {
  final Dish dish;

  RemoveDishEvent(this.dish);

  @override
  List<Object> get props => [dish];

  @override
  String toString() => 'Remove/' + dish.toString();
}

@immutable
class RemoveOrderPositionEvent extends CurrentOrderEvent {
  final OrderPosition position;

  RemoveOrderPositionEvent(this.position);

  @override
  List<Object> get props => [position];

  @override
  String toString() => 'DeletePos/' + position.toString();
}

@immutable
class ClearOrderEvent extends CurrentOrderEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Clear';
}
