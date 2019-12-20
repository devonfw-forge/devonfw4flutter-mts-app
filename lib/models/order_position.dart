import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

///Holds a [Dish] and describes how many times that [Dish] should be ordered
///
///
///#### Why Equatable?
///Extends [Equatable] to overwrite it's comparison behavior. 
///It will be compared based on it's [props] instead of it's reference.
///This way we can easily compare if 2 [OrderPosition]es are the same, based on
///their values and not based on their location in memory.
///
///#### Why Immutable?
///All model classes are [immutable] because all models are or are part of 
///event and state classes. event and state classes are required to be [immutable]
///by the bloc package for the following reasons (1):
/// - It allows the library to detect state changes efficiently
/// - It makes handling data safer (no side-effects or mutations)
/// - It makes state management predictable because we're using static 
///   snapshots of our state instead of state which can change at any 
///   point in time leading to strange/unpredictable behavior.
///
///In general, we should always strive to designing software so that as many
///structures as feasible are immutable (2).
///
///(1) Felix Angelov, 2019 https://github.com/felangel/bloc/issues/292
///(2) J. Bloch, Effective Java, Second Edition. Upper Saddle River, NJ:
///Addison-Wesley, 2008
@immutable
class OrderPosition extends Equatable {
  final Dish dish;
  final int amount;
  final double price;

  OrderPosition({this.dish, this.amount}) : price = _getPrice(dish, amount);

  @override
  List<Object> get props => [dish, amount];

  @override String toString() => '${amount.toString()} ${dish.name}';

  ///Pre-calculates total price of [OrderPosition]
  static double _getPrice(Dish dish, int amount) => dish.price * amount;

  ///Provides a formatted String that displays the total
  ///price of  [OrderPosition] 
  ///
  ///Example: '12,60 €'
  String get formattedPrice => price.toStringAsFixed(2) + ' €';

  OrderPosition copyWith({
    Dish dish,
    int amount,
  }) =>
      OrderPosition(
        dish: dish ?? this.dish,
        amount: amount ?? this.amount,
      );
}
