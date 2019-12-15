import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
abstract class DishState extends Equatable {}

@immutable
class ReceivedDishState extends DishState {
  final List<Dish> dishes;

  ReceivedDishState(this.dishes);

  @override
  List<Object> get props => [dishes];
}

@immutable
class ErrorDishState extends DishState {
  final String errorMessage;

  ErrorDishState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

@immutable
class LoadingDishState extends DishState {
  @override
  List<Object> get props => ["loading"];
}