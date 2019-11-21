import 'package:equatable/equatable.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/_booking.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class UpdateBookingEvent extends BookingEvent {
  final Booking booking;

  UpdateBookingEvent(this.booking);

  @override
  List<Object> get props => [booking];
}

class ConfirmBookingEvent extends BookingEvent {
  @override
  List<Object> get props => [];
}
