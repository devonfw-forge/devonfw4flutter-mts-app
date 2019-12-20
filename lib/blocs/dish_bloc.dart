import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/data/dish_service.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

import 'package:my_thai_star_flutter/blocs/dish_state.dart';

enum DishEvents { request }

class DishBloc extends Bloc<DishEvents, DishState> {
  final CurrentSearchBloc _searchBloc;
  final ExchangePoint _dishService = DishService();

  DishBloc(searchBloc) : _searchBloc = searchBloc;

  @override
  DishState get initialState => LoadingDishState();

  @override
  Stream<DishState> mapEventToState(DishEvents event) async* {
    Search currentSearch = _searchBloc.currentState;

    yield LoadingDishState();

    try {
      yield await _loadDishes(currentSearch);
    } catch (e) {
      yield ErrorDishState(e.toString());
    }
  }

  Future<DishState> _loadDishes(Search currentSearch) async {
    List<Dish> newState = await _dishService.post(currentSearch);
    if (newState == null) {
      return ErrorDishState('The Response was Empty');
    } else {
      return ReceivedDishState(newState);
    }
  }
}
