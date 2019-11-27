import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'current_order_event.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, Map<Dish, int>> {

  @override
  Map<Dish, int> get initialState => Map();

  @override
  Stream<Map<Dish, int>> mapEventToState(CurrentOrderEvent event) async* {
    Map<Dish, int> newOrder = Map()..addAll(currentState);

    if (event is AddOrderEvent) {
      if (newOrder.containsKey(event.order)) {
        newOrder[event.order]++;
      } else {
        newOrder[event.order] = 1;
      }
    }

    if (event is RemoveOrderEvent) {
      if (newOrder.containsKey(event.order)) {
        if (newOrder[event.order] > 1) {
          newOrder[event.order]--;
        }else{
          newOrder.remove(event.order);
        }
      }
    }

    if(event is DeleteOrderPositionEvent){
      if (newOrder.containsKey(event.order)) {
        newOrder.remove(event.order);
      }
    }

    yield newOrder;
  }
}
