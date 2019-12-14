import 'package:flutter/cupertino.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

class BookingFormBloc extends FormBaseBloc<Booking> {
  final EmailFieldBloc emailBloc;
  final DateFieldBloc dateBloc;
  final NonEmptyFieldBloc nameBloc;
  final NumberFieldBloc guestBloc;
  final CheckboxFieldBloc termsBloc;

  BookingFormBloc(
      {@required this.emailBloc,
      @required this.dateBloc,
      @required this.nameBloc,
      @required this.guestBloc,
      @required this.termsBloc})
      : super([
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
      date = dateBloc.format.parse(dateBloc.currentState.data);
    } catch (e) {
      date = null;
    }
    int guests;
    try {
      guests = int.parse(guestBloc.currentState.data);
    } catch (e) {
      guests = null;
    }

    if (isFormValid()) {
      yield ValidState(Booking(
        name: nameBloc.currentState.data,
        organizerEmail: emailBloc.currentState.data,
        date: date,
        guests: guests,
        termsAccepted: termsBloc.currentState.data,
      ));
    } else {
      yield InvalidState(Booking(
        name: nameBloc.currentState.data,
        organizerEmail: emailBloc.currentState.data,
        date: date,
        guests: guests,
        termsAccepted: termsBloc.currentState.data,
      ));
    }
  }
}
