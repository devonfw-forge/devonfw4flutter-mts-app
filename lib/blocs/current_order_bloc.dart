import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'current_order_event.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, Map<Dish, int>> {
  Map<Dish, int> dishes = {
    Dish(
        name: "THAI GREEN CHICKEN CURRY",
        description: "Master this aromatic, creamy & extremely tasty" +
            " chicken Thai green curry recipe from Jamie Oliver & treat" +
            " yourself to an authentic taste of South East Asia.",
        price: 14.75,
        imageLocation: "assets/images/green-curry.jpg",
        extras: [
          "Tofu",
          "Extra Curry",
        ]): 1,
    Dish(
        name: "THAI SPICY BASIL FRIED RICE",
        description: "This is a staple of Thai cooking. " +
            "Adjust the spices to your own tastes for a really " +
            "great use for leftover rice!! I get the basil from a " +
            "local Asian market. It has a different flavor than " +
            "that of regular basil and makes all the difference " +
            "in this recipe. It is fast and fairly easy to make, " +
            "but requires constant stirring",
        price: 12.99,
        imageLocation: "assets/images/basil-fried.jpg",
        extras: ["Tofu", "Extra Curry"]): 2
  };

  @override
  Map<Dish, int> get initialState => dishes;

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
