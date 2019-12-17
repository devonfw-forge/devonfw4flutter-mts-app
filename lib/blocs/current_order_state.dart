import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

@immutable
abstract class CurrentOrderState implements Equatable {
  final LinkedHashMap<Dish, int> dishMap;

  CurrentOrderState(this.dishMap);

  int numberOfDishes() {
    int amount = 0;
    dishMap.forEach((d, i) => amount += i);
    return amount;
  }

  double positionPrice(Dish dish) => dish.price * dishMap[dish];

  double totalPrice() {
    double p = 0;
    dishMap.forEach((dish, amount) => p += positionPrice(dish));
    return p;
  }

  String get formatedTotalPrice => totalPrice().toStringAsFixed(2);
  String formatedPositionPrice(Dish dish) => positionPrice(dish).toStringAsFixed(2);
}

@immutable
class InitialCurrentOrderState extends CurrentOrderState {
  InitialCurrentOrderState() : super(LinkedHashMap());

  @override
  List<Object> get props => ["initial"];
}

@immutable
class IdleCurrentOrderState extends CurrentOrderState {
  IdleCurrentOrderState(LinkedHashMap<Dish, int> dishMap) : super(dishMap);

  @override
  List<Object> get props => [dishMap, numberOfDishes(), totalPrice()];
}
