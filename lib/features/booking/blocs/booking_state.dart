import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

abstract class BookingState extends Equatable {
  final Booking booking;
  const BookingState(this.booking);
}

class InitialBookingState extends BookingState {
  InitialBookingState(booking) : super(booking);

  @override
  List<Object> get props => [booking];
}

class ConfirmedBookingState extends BookingState {
  ConfirmedBookingState(booking) : super(booking);

  @override
  List<Object> get props => [booking];
}

class LoadingBookingState extends BookingState {
  LoadingBookingState(booking) : super(booking);

  @override
  List<Object> get props => [booking];
}

class DeclinedBookingState extends BookingState {
  final String reason;
  DeclinedBookingState(booking, this.reason) : super(booking);

  @override
  List<Object> get props => [booking, reason];
}

class InProgressBookingState extends BookingState {
  InProgressBookingState(booking) : super(booking);

  @override
  List<Object> get props => [booking];
}
