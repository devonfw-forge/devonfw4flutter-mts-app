import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/search.dart';

abstract class DishState extends Equatable {
  final Search lastSearch;
  const DishState(this.lastSearch);
}

class IdleDishState extends DishState {
  final List<Dish> dishes;

  IdleDishState(this.dishes, lastSearch) : super(lastSearch);

  @override
  List<Object> get props => [dishes, lastSearch];
}

class ErrorDishState extends DishState {
  final String error;

  ErrorDishState(this.error, lastSearch) : super(lastSearch);

  @override
  List<Object> get props => [error, lastSearch];
}
