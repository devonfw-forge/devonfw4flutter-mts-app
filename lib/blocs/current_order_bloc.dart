import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';

import 'package:my_thai_star_flutter/blocs/current_order_event.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

///Handles the state of the current order
///
///Consumes [CurrentOrderEvent] and mutates the current order
///based on those events. It then emits [CurrentOrderState] describing
///the new State of the order
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

    //Get index of OrderPosition with the same dish as the AddDishEvent
    int index = newPositions.indexWhere(
      (OrderPosition pos) => pos.dish == event.dish,
    );

    if (index != -1) {
      //Found a fiting OrderPosition.
      //So add to the amount
      newPositions[index] = newPositions[index].copyWith(
        amount: newPositions[index].amount + 1,
      );
    } else {
      //Dish not fin a fiting OrderPosition.
      //So add a new one
      newPositions.add(OrderPosition(
        dish: event.dish,
        amount: 1,
      ));
    }
    yield IdleCurrentOrderState(newPositions);
  }

  Stream<CurrentOrderState> _removeDish(RemoveDishEvent event) async* {
    List<OrderPosition> newPositions = List()..addAll(currentState.positions);

    //Get index of OrderPosition with the same dish as the AddDishEvent
    int index = newPositions.indexWhere(
      (OrderPosition pos) => pos.dish == event.dish,
    );

    if (index != -1) {
      //Found a fiting OrderPosition
      if (newPositions[index].amount > 1) {
        //Decreeing the amount wont remove the OrderPosition
        //So just decrees the amount
        newPositions[index] = newPositions[index].copyWith(
          amount: newPositions[index].amount - 1,
        );
      } else {
        //Decreeing the amount will remove the OrderPosition
        //So remove it
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
}
