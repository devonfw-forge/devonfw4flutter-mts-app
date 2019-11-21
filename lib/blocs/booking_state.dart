import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/_booking.dart';

abstract class BookingState extends Equatable {
  const BookingState();
}

class CreatingBookingState extends BookingState {
  final Booking currentBooking;

  CreatingBookingState(this.currentBooking);

  @override
  List<Object> get props => [currentBooking];
}

class ConfirmedBookingState extends BookingState {
  final String bookingNumber;

  ConfirmedBookingState(this.bookingNumber);

  @override
  List<Object> get props => [bookingNumber];
}

class DeclinedBookingState extends BookingState {
  @override
  List<Object> get props => [];
}
