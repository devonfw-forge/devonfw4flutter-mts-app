import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_event.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/_booking.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  @override
  BookingState get initialState => InitialBookingState();

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    // TODO: Add Logic
  }
}
