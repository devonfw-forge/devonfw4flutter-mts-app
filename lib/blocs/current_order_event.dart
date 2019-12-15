import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
abstract class CurrentOrderEvent extends Equatable {
  const CurrentOrderEvent();
}

@immutable
class AddDishToOrderEvent extends CurrentOrderEvent {
  final Dish order;

  AddDishToOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

@immutable
class RemoveDishFromOrderEvent extends CurrentOrderEvent {
  final Dish order;

  RemoveDishFromOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

@immutable
class DeleteOrderPositionEvent extends CurrentOrderEvent {
  final Dish order;

  DeleteOrderPositionEvent(this.order);

  @override
  List<Object> get props => [order];
}

@immutable
class ClearOrderEvent extends CurrentOrderEvent {
  @override
  List<Object> get props => ["clear"];
}
