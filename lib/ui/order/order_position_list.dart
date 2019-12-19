
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/ui/order/order_position_display.dart';

///Defines a [SliverList] of [OrderPositionDisplays]s
class OrderPositionList extends StatelessWidget {
  final LinkedHashMap<Dish, int> _dishes;

  const OrderPositionList({Key key, @required dishes})
      : _dishes = dishes,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Dish dish = _dishes.keys.toList()[index];
          int amount = _dishes[dish];

          return OrderPositionDisplay(dish: dish, amount: amount);
        },
        childCount: _dishes.length,
      ),
    );
  }
}