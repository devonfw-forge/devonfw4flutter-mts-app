import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'order_event.dart';


class CurrentOrderBloc extends Bloc<OrderEvent, LinkedHashMap<Dish, int>> {
  @override
  LinkedHashMap<Dish, int> get initialState => LinkedHashMap();

  @override
  Stream<LinkedHashMap<Dish, int>> mapEventToState(OrderEvent event) async* {
    LinkedHashMap<Dish, int> newOrder = LinkedHashMap()..addAll(currentState);

    if (event is AddDishToOrderEvent) {
      if (newOrder.containsKey(event.order)) {
        newOrder[event.order]++;
      } else {
        newOrder[event.order] = 1;
      }
    }

    if (event is RemoveDishFromOrderEvent) {
      if (newOrder.containsKey(event.order)) {
        if (newOrder[event.order] > 1) {
          newOrder[event.order]--;
        } else {
          newOrder.remove(event.order);
        }
      }
    }

    if (event is DeleteOrderPositionEvent) {
      if (newOrder.containsKey(event.order)) {
        newOrder.remove(event.order);
      }
    }

    yield newOrder;
  }

}
