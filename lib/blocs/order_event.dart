import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class AddDishToOrderEvent extends OrderEvent {
  final Dish order;

  AddDishToOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class RemoveDishFromOrderEvent extends OrderEvent {
  final Dish order;

  RemoveDishFromOrderEvent(this.order);

  @override
  List<Object> get props => [order];
}

class DeleteOrderPositionEvent extends OrderEvent {
  final Dish order;

  DeleteOrderPositionEvent(this.order);

  @override
  List<Object> get props => [order];
}

class ConfirmOrderEvent extends OrderEvent {
  final String bookingNumber;

  ConfirmOrderEvent(this.bookingNumber);

  @override
  List<Object> get props => [bookingNumber];
}
