import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

abstract class CurrentOrderEvent extends Equatable {
  const CurrentOrderEvent();
}

class AddOrderEvent extends CurrentOrderEvent {
  final Dish order;

  AddOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class RemoveOrderEvent extends CurrentOrderEvent {
  final Dish order;

  RemoveOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class DeleteOrderPositionEvent extends CurrentOrderEvent {
  final Dish order;

  DeleteOrderPositionEvent(this.order);

  @override
  List<Object> get props => [order];
}
