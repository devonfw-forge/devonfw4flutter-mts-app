import 'package:flutter/material.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/models/booking.dart';

class BookingFormBloc extends FormBaseBloc<Booking> {
  final EmailFieldBloc _emailBloc;
  final DateFieldBloc _dateBloc;
  final NonEmptyFieldBloc _nameBloc;
  final NumberFieldBloc _guestBloc;
  final CheckboxFieldBloc _termsBloc;

  BookingFormBloc({
    @required emailBloc,
    @required dateBloc,
    @required nameBloc,
    @required guestBloc,
    @required termsBloc,
  })  : _emailBloc = emailBloc,
        _dateBloc = dateBloc,
        _nameBloc = nameBloc,
        _guestBloc = guestBloc,
        _termsBloc = termsBloc,
        super([
          emailBloc,
          dateBloc,
          nameBloc,
          guestBloc,
          termsBloc,
        ]);

  @override
  ValidationState<Booking> get initialState => InitialState(Booking());

  @override
  Stream<ValidationState<Booking>> mapEventToState(FormEvent event) async* {
    DateTime date;
    try {
      date = _dateBloc.format.parse(_dateBloc.currentState.data);
    } catch (e) {
      date = null;
    }
    int guests;
    try {
      guests = int.parse(_guestBloc.currentState.data);
    } catch (e) {
      guests = null;
    }

    if (isFormValid()) {
      yield ValidState(Booking(
        name: _nameBloc.currentState.data,
        organizerEmail: _emailBloc.currentState.data,
        date: date,
        guests: guests,
        termsAccepted: _termsBloc.currentState.data,
      ));
    } else {
      yield InvalidState(Booking(
        name: _nameBloc.currentState.data,
        organizerEmail: _emailBloc.currentState.data,
        date: date,
        guests: guests,
        termsAccepted: _termsBloc.currentState.data,
      ));
    }
  }
}
