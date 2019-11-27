import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'current_order_event.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, List<Dish>> {
final List<Dish> dishes = [
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
        ]),
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
        extras: ["Tofu", "Extra Curry"]),
  ];

  @override
  List<Dish> get initialState => dishes;

  @override
  Stream<List<Dish>> mapEventToState(CurrentOrderEvent event) async* {
    yield dishes;

    //List<Dish> newFavorites = List()..addAll(currentState);

    //if (event is AddOrderEvent) newFavorites.add(event.order);
    //if (event is RemoveOrderEvent) newFavorites.remove(event.order);

    //yield newFavorites;
  }
}
