import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/models/order_position.dart';

///Links a list of [OrderPosition]s to a placed [Booking] through a booking token
///
///We receive a booking token from the MyThaiStar API after successfully
///placing a [Booking]. We can use this token to order [Dish]es for that [Booking].
///This class is sent to the [BookingService] to order the [Order.positions] for
///the [Booking] linked to the [Order.bookingToken].
///
///More info: https://github.com/Fasust/my-thai-star-flutter/blob/master/lib/models/README.md
@immutable
class Order extends Equatable {
  final List<OrderPosition> positions;
  final String bookingToken;

  Order({@required this.positions, @required this.bookingToken});

  @override
  List<Object> get props => [positions, bookingToken];
}
