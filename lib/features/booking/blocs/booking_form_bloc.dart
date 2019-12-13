import 'package:flutter/cupertino.dart';
import 'package:form_validation_bloc/barrel.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

class BookingFormBloc extends FormBloc<Booking> {
  final EmailValidationBloc emailBloc;
  final DateValidationBloc dateBloc;
  final NonEmptyValidationBloc nameBloc;
  final NumberValidationBloc guestBloc;
  final CheckboxValidationBloc termsBloc;

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
