import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BookingState extends Equatable {}

@immutable
class InitialBookingState extends BookingState {
  @override
  List<Object> get props => ["initial"];
}

@immutable
class ConfirmedBookingState extends BookingState {
  final String token;

  ConfirmedBookingState(this.token);

  @override
  List<Object> get props => [token];
}

@immutable
class LoadingBookingState extends BookingState {
  @override
  List<Object> get props => ["loading"];
}

@immutable
class DeclinedBookingState extends BookingState {
  final String reason;
  DeclinedBookingState(this.reason);

  @override
  List<Object> get props => [reason];
}
