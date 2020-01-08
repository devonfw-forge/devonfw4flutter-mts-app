import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/repositories/service.dart';

import 'package:my_thai_star_flutter/blocs/dish_state.dart';

///Gives the ability to request new [Dish]es from
///the [DishBloc]
///
///Is an enum because it does not need to carry any additional data.
///The [DishBloc] already has everything it need because it is injected with
///the [CurrentSearchBloc] on creation.
enum DishEvents { request }

///Handles the fetching of [Dish]es that match the [Search] defined
///by the [CurrentSearchBloc]
///
///When receiving a [DishEvents.request], the [DishBloc] uses the
///current state of the [CurrentSearchBloc] to fetch new [Dish]es form
///it's [_dishService]. The [DishBloc] then emits new [DishState] reflecting
///the result of that communication.
///
///#### Why inject the CurrentSearchBloc?
///I did this so that the UI does not need access to 2 blocs every time
///it needs to request new [Dish]es.
class DishBloc extends Bloc<DishEvents, DishState> {
  final CurrentSearchBloc _searchBloc;
  final Service<Search, List<Dish>> _dishService;

  ///Creates one [DishBloc]
  ///
  ///The dependency on the the [_dishService] &
  ///[CurrentSearchBloc] are injected.
  DishBloc({@required searchBloc, @required dishService})
      : _searchBloc = searchBloc,
        _dishService = dishService;

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
    return ReceivedDishState(newState);
  }
}
