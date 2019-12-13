import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class SetDateEvent extends BookingEvent {
  final DateTime date;

  SetDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class SetNameEvent extends BookingEvent {
  final String name;

  SetNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class SetEmailEvent extends BookingEvent {
  final String email;

  SetEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class SetGuestsEvent extends BookingEvent {
  final int guests;

  SetGuestsEvent(this.guests);

  @override
  List<Object> get props => [guests];
}

class SetTermsAcceptedEvent extends BookingEvent {
  final bool terms;

  SetTermsAcceptedEvent(this.terms);

  @override
  List<Object> get props => [terms];
}

class RequestBookingEvent extends BookingEvent {

  @override
  List<Object> get props => ["request"];
}
class ClearBookingContentsEvent extends BookingEvent {

  @override
  List<Object> get props => ["clear"];
}
