import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BookingState extends Equatable {}

@immutable
class InitialBookingState extends BookingState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => "Initial";
}

@immutable
class ConfirmedBookingState extends BookingState {
  final String token;

  ConfirmedBookingState(this.token);

  @override
  List<Object> get props => [token];

  @override
  String toString() => "Confirmed/Token: " + token;
}

@immutable
class LoadingBookingState extends BookingState {
  @override
  List<Object> get props => [toString()];

  @override
  String toString() => "Loading";
}

@immutable
class DeclinedBookingState extends BookingState {
  final String reason;

  DeclinedBookingState(this.reason);

  @override
  List<Object> get props => [reason];

  @override
  String toString() => "Declined/Reason: " + reason;
}
