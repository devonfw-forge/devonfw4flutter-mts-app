import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/features/menu/models/dish.dart';

abstract class DishState extends Equatable {}

class ReceivedDishState extends DishState {
  final List<Dish> dishes;

  ReceivedDishState(this.dishes);

  @override
  List<Object> get props => [dishes];
}

class ErrorDishState extends DishState {
  final String errorMessage;

  ErrorDishState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoadingDishState extends DishState {
  @override
  List<Object> get props => ["loading"];
}
