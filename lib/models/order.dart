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
///
///#### Why Equatable?
///Extends [Equatable] to overwrite it's comparison behavior. 
///It will be compared based on it's [props] instead of it's reference.
///This way we can easily compare if 2 [Order]s are the same, based on
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
///Addison-Wesley, 2008.
@immutable
class Order extends Equatable {
  final List<OrderPosition> positions;
  final String bookingCode;

  Order({@required this.positions, @required this.bookingCode});

  @override
  List<Object> get props => [positions, bookingCode];
}
