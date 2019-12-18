import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
abstract class CurrentOrderEvent extends Equatable {}

@immutable
class AddDishToOrderEvent extends CurrentOrderEvent {
  final Dish dish;

  AddDishToOrderEvent(this.dish);

  @override
  List<Object> get props => [dish];

  @override
  String toString() => "Add/" + dish.toString();
}

@immutable
class RemoveDishFromOrderEvent extends CurrentOrderEvent {
  final Dish dish;

  RemoveDishFromOrderEvent(this.dish);

  @override
  List<Object> get props => [dish];

  @override
  String toString() => "Remove/" + dish.toString();
}

@immutable
class DeleteOrderPositionEvent extends CurrentOrderEvent {
  final Dish dish;

  DeleteOrderPositionEvent(this.dish);

  @override
  List<Object> get props => [dish];

  @override
  String toString() => "DeletePos/" + dish.toString();
}

@immutable
class ClearOrderEvent extends CurrentOrderEvent {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => "Clear";
}
