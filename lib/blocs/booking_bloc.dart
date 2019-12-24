import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/models/booking.dart';

///Handles the placing of [Booking]s
///
///Consumes [Booking]s as events and sends them to
///it's [_bookingService].
///Emits [BookingState] describing the state of that
///process. (Confirmed, Declined, Loading etc.)
class BookingBloc extends Bloc<Booking, BookingState> {
  final Service<Booking, String> _bookingService;

  ///Creates one [BookingBloc]
  ///
  ///The dependency on the the [_bookingService] is injected.
  BookingBloc({@required bookingService}) : _bookingService = bookingService;

  @override
  BookingState get initialState => InitialBookingState();

  @override
  Stream<BookingState> mapEventToState(Booking event) async* {
    yield LoadingBookingState();

    String bookingToken;
    try {
      bookingToken = await _bookingService.post(event);

      yield ConfirmedBookingState(bookingToken);
    } catch (e) {
      yield DeclinedBookingState(e.toString());
    }
  }
}
