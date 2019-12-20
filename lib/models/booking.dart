import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Defines a reservation placed in the fictional MyThaiStar restaurant
@immutable
class Booking extends Equatable {
  static final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  final DateTime date;
  final String name;
  final String organizerEmail;
  final int guests;
  final bool termsAccepted;

  Booking(
      {this.date,
      this.name,
      this.organizerEmail,
      this.guests,
      this.termsAccepted});

  Booking copyWith({
    DateTime date,
    String name,
    String organizerEmail,
    int guests,
    bool termsAccepted,
  }) =>
      Booking(
        date: date ?? this.date,
        name: name ?? this.name,
        organizerEmail: organizerEmail ?? this.organizerEmail,
        guests: guests ?? this.guests,
        termsAccepted: termsAccepted ?? this.termsAccepted,
      );

  @override
  List<Object> get props => [date, name, organizerEmail, guests, termsAccepted];
}
