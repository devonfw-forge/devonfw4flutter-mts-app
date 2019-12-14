import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

abstract class CurrentOrderEvent extends Equatable {
  const CurrentOrderEvent();
}

class AddDishToOrderEvent extends CurrentOrderEvent {
  final Dish order;

  AddDishToOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class RemoveDishFromOrderEvent extends CurrentOrderEvent {
  final Dish order;

  RemoveDishFromOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class DeleteOrderPositionEvent extends CurrentOrderEvent {
  final Dish order;

  DeleteOrderPositionEvent(this.order);

  @override
  List<Object> get props => [order];
}
class ClearOrderEvent extends CurrentOrderEvent {

  @override
  List<Object> get props => ["clear"];
}