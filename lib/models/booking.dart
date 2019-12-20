import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Defines a reservation placed in the fictional MyThaiStar restornat
///
///#### Why Equatable?
///Extends [Equatable] to overwrite it's comparison behavior. 
///It will be compared based on it's [props] instead of it's reference.
///This way we can easily compare if 2 [Booking]s are the same, based on
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
