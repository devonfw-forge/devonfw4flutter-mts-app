import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

abstract class BookingState extends Equatable {
  final Booking currentBooking;
  const BookingState(this.currentBooking);
}

class ConfirmedBookingState extends BookingState {
  final String bookingNumber;

  ConfirmedBookingState({this.bookingNumber, currentBooking})
      : super(currentBooking);

  @override
  List<Object> get props => [bookingNumber, currentBooking];
}

class DeclinedBookingState extends BookingState {
  DeclinedBookingState({currentBooking}) : super(currentBooking);

  @override
  List<Object> get props => [currentBooking];
}
