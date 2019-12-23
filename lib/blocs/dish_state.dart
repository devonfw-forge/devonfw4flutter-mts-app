import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

///Describes how the process of fetching [Dish]es is going
@immutable
abstract class DishState extends Equatable {}

@immutable
class ReceivedDishState extends DishState {
  final List<Dish> dishes;

  ReceivedDishState(this.dishes);

  @override
  List<Object> get props => [dishes];

  @override
  String toString() => 'Received/NumberOfDishes: ' + dishes.length.toString();
}

@immutable
class ErrorDishState extends DishState {
  final String errorMessage;

  ErrorDishState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'Error/Message: ' + errorMessage;
}

@immutable
class LoadingDishState extends DishState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => 'Loading';
}
