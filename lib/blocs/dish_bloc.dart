import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/data/dish_service.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';

import 'dish_state.dart';

class DishBloc extends Bloc<Search, DishState> {
  ExchangePoint dishService = DishService();

  @override
  DishState get initialState => IdleDishState(List(), Search());

  @override
  Stream<DishState> mapEventToState(Search event) async* {
    try {
      List<Dish> newState = await dishService.post(event);

      if (newState == null) {
        yield ErrorDishState("The Response was Empty", event);
      } else {
        yield IdleDishState(newState, event);
      }
    } catch (e) {
      yield ErrorDishState(e.toString(), event);
    }
  }
}