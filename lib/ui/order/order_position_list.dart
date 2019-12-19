import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';
import 'package:my_thai_star_flutter/ui/order/order_position_display.dart';

///Defines a [SliverList] of [OrderPositionDisplays]s
class OrderPositionList extends StatelessWidget {
  final List<OrderPosition> _positions;

  const OrderPositionList({Key key, @required positions})
      : _positions = positions,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>
            OrderPositionDisplay(position: _positions[index]),
        childCount: _positions.length,
      ),
    );
  }
}
