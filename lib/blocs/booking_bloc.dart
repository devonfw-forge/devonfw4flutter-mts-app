import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/data/booking_service.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/models/booking.dart';

class BookingBloc extends Bloc<Booking, BookingState> {
  final ExchangePoint _exchangePoint = BookingService();

  @override
  BookingState get initialState => InitialBookingState();

  @override
  Stream<BookingState> mapEventToState(Booking event) async* {
    yield LoadingBookingState();

    String bookingToken;
    try {
      bookingToken = await _exchangePoint.post(event);

      if (bookingToken != null) {
        yield ConfirmedBookingState(bookingToken);
      } else {
        yield DeclinedBookingState('Did not receive a valid booking ID');
      }
    } catch (e) {
      yield DeclinedBookingState(e.toString());
    }
  }
}
