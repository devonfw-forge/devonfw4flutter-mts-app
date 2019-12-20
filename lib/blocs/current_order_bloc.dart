import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, CurrentOrderState> {
  @override
  CurrentOrderState get initialState => InitialCurrentOrderState();

  @override
  Stream<CurrentOrderState> mapEventToState(CurrentOrderEvent event) async* {
    if (event is AddDishEvent) {
      yield* _addDish(event);
    } else if (event is RemoveDishEvent) {
      yield* _removeDish(event);
    } else if (event is RemoveOrderPositionEvent) {
      yield* _removePosition(event);
    } else if (event is ClearOrderEvent) {
      yield IdleCurrentOrderState(List());
    }
  }

  Stream<CurrentOrderState> _addDish(AddDishEvent event) async* {
    List<OrderPosition> newPositions = List()..addAll(currentState.positions);

    int index = _getIndex(newPositions, event.dish);

    if (index != null) {
      OrderPosition position = newPositions[index];
      newPositions[index] = position.copyWith(amount: position.amount + 1);
    } else {
      newPositions.add(OrderPosition(dish: event.dish, amount: 1));
    }
    yield IdleCurrentOrderState(newPositions);
  }

  Stream<CurrentOrderState> _removeDish(RemoveDishEvent event) async* {
    List<OrderPosition> newPositions = List()..addAll(currentState.positions);

    int index = _getIndex(newPositions, event.dish);

    if (index != null) {
      OrderPosition position = newPositions[index];
      if (position.amount > 1) {
        newPositions[index] = position.copyWith(amount: position.amount - 1);
      } else {
        newPositions.removeAt(index);
      }
    }
    yield IdleCurrentOrderState(newPositions);
  }

  Stream<CurrentOrderState> _removePosition(
      RemoveOrderPositionEvent event) async* {
    List<OrderPosition> newPositions = List()..addAll(currentState.positions);

    if (newPositions.contains(event.position)) {
      newPositions.remove(event.position);
    }
    yield IdleCurrentOrderState(newPositions);
  }

  int _getIndex(List<OrderPosition> positions, Dish dish) {
    int index;
    for (int i = 0; i < positions.length; i++) {
      if (positions[i].dish == dish) {
        index = i;
      }
    }
    return index;
  }
}
