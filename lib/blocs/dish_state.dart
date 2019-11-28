import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/search.dart';

abstract class DishState extends Equatable {
  const DishState();
}

class IdleDishState extends DishState {
  final List<Dish> dishes;
  final Search lastSearch;

  IdleDishState(this.dishes, this.lastSearch);

  @override
  List<Object> get props => [dishes, lastSearch];
}
class ErrorDishState extends DishState {
  final String error;
   final Search lastSearch;

  ErrorDishState(this.error, this.lastSearch);

  @override
  List<Object> get props => [error, lastSearch];
}
