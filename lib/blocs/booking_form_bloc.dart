import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:my_thai_star_flutter/models/booking.dart';

///Handles the current state of the [BookingForm]
///
///When the [Bloc.currentState] of all it's [FieldBloc]s is
///[ValidState], the [BookingFormBloc] will emit a [ValidState] 
///carrying the current [Booking]. 
///If any of it's [BookingFormBloc] are invalid, [BookingFormBloc] 
///will emit a [InvalidState] carrying the current invalid [Booking].
class BookingFormBloc extends FormBaseBloc<Booking> {
  final EmailFieldBloc _emailBloc;
  final DateFieldBloc _dateBloc;
  final NonEmptyFieldBloc _nameBloc;
  final NumberFieldBloc _guestBloc;

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
        super([
          emailBloc,
          dateBloc,
          nameBloc,
          guestBloc,
          termsBloc,
        ]);

  @override
  ValidationState<Booking> get initialState => InitialState(Booking());

  ///Called every time one of the [FieldBloc]s of [FormBaseBloc] changes state
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
      ));
    } else {
      yield InvalidState(Booking(
        name: _nameBloc.currentState.data,
        organizerEmail: _emailBloc.currentState.data,
        date: date,
        guests: guests,
      ));
    }
  }
}
