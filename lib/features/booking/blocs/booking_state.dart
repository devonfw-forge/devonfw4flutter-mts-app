import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {}

class InitialBookingState extends BookingState {
  
  @override
  List<Object> get props => ["initial"];
}

class ConfirmedBookingState extends BookingState {
  final String bookingId;

  ConfirmedBookingState(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}

class LoadingBookingState extends BookingState {

  @override
  List<Object> get props => ["loading"];
}

class DeclinedBookingState extends BookingState {
  final String reason;
  DeclinedBookingState(this.reason);

  @override
  List<Object> get props => [reason];
}
