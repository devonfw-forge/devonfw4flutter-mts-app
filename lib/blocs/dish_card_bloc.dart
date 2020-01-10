import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/dish_card_event.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/extra.dart';

///Handles the state of a [DishCard] IE. the state of the [Dish] 
///displayed by a [DishCard]
///
///Consumes [DishCardEvent] and mutates the [Dish] accordingly.
///It the emits the new [Dish] as state. It's initial state is defined
///by the [Dish] that is injected on creation.
///
///For now it is only responsible for changing which [Extra]s are selected,
///because this is currently the only way that the state of a [Dish] can be
///modified.
class DishCardBloc extends Bloc<DishCardEvent, Dish> {
  final Dish initialDish;

  DishCardBloc(this.initialDish);

  @override
  Dish get initialState => initialDish;

  @override
  Stream<Dish> mapEventToState(DishCardEvent event) async* {
    if (event is SetExtraEvent) {

      //Hard clone the map so it is recognized as a new entity
      Map<Extra, bool> newExtras = Map.from(currentState.extras);
      newExtras[event.extra] = event.picked;

      Dish newState = currentState.copyWith(extras: newExtras);
      yield newState;
    }
  }
}
