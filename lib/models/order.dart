import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

@immutable
class Order extends Equatable {
  final List<OrderPosition> positions;
  final String bookingCode;

  Order({@required this.positions, @required this.bookingCode});

  @override
  List<Object> get props => [positions, bookingCode];
}
