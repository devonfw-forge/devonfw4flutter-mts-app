import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_events.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/features/booking/data/booking_service.dart';
import 'package:my_thai_star_flutter/repositories/exchange_point.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final ExchangePoint _exchangePoint = BookingService();

  @override
  BookingState get initialState => InitialBookingState(Booking());

  @override
  Stream<BookingState> mapEventToState(BookingEvent event) async* {
    if (event is SetDateEvent) {
      yield* mapSetDateToState(event);
    } else if (event is SetNameEvent) {
      yield* mapSetNameToState(event);
    } else if (event is SetEmailEvent) {
      yield* mapSetEmailToState(event);
    } else if (event is SetGuestsEvent) {
      yield* mapSetGuestsToState(event);
    } else if (event is SetTermsAcceptedEvent) {
      yield* mapSetTermsToState(event);
    } else if (event is RequestBookingEvent) {
      yield* mapRequestBookingToState(event);
    }
  }

  Stream<BookingState> mapSetDateToState(SetDateEvent event) async* {
    Booking newBooking = currentState.booking
        .copyWith(date: event.date);
    yield InProgressBookingState(newBooking);
  }

  Stream<BookingState> mapSetNameToState(SetNameEvent event) async* {
    Booking newBooking = currentState.booking.copyWith(name: event.name);
    yield InProgressBookingState(newBooking);
  }

  Stream<BookingState> mapSetEmailToState(SetEmailEvent event) async* {
    Booking newBooking =
        currentState.booking.copyWith(organizerEmail: event.email);
    yield InProgressBookingState(newBooking);
  }

  Stream<BookingState> mapSetGuestsToState(SetGuestsEvent event) async* {
    Booking newBooking = currentState.booking.copyWith(guests: event.guests);
    yield InProgressBookingState(newBooking);
  }

  Stream<BookingState> mapSetTermsToState(SetTermsAcceptedEvent event) async* {
    Booking newBooking =
        currentState.booking.copyWith(termsAccepted: event.terms);
    yield InProgressBookingState(newBooking);
  }

  Stream<BookingState> mapRequestBookingToState(
      RequestBookingEvent event) async* {
    yield LoadingBookingState(currentState.booking);

    String bookingNumber;
    try {
      bookingNumber = await _exchangePoint.post(currentState.booking);

      if (bookingNumber != null) {
        Booking newBooking =
            currentState.booking.copyWith(bookingNumber: bookingNumber);
        yield ConfirmedBookingState(newBooking);
      } else {
        yield DeclinedBookingState(currentState.booking, "Did not receive a valid booking ID");
      }
    } catch (e) {
      yield DeclinedBookingState(currentState.booking, e.toString());
    }
  }
}
