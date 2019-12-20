import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

///Defines an order with a list of [Dish]es that are linked to a [Booking] 
///through a booking token
///
///The link between [Booking] & [Order] happens in the back-end, so we
///do not need to worry about it in our models. To add an [Order] to 
///a booking that was successfully sent to the back-end, we attach the 
///booking token we received after placing that booking.
///
///#### Why OrderPosions?
///We use [OrderPosition]s and just a [List<Dish>] because that is closer
///to the front-end representation in the [OrderPage]. If we had a [List<Dish>]
///we would need to do a lot of formatting in the UI which is against
///th Bloc-pattern
@immutable
class Order extends Equatable {
  final List<OrderPosition> positions;
  final String bookingCode;

  Order({@required this.positions, @required this.bookingCode});

  @override
  List<Object> get props => [positions, bookingCode];
}
