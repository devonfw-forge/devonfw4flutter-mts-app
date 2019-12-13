import 'package:bool_bloc/bool_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/date_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/email_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/name_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/number_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

class BookingFormBloc extends FormBloc<Booking> {
  final NameFieldBloc nameBloc;
  final DateFieldBloc dateBloc;
  final EmailFieldBloc emailBloc;
  final NumberFieldBloc guestBloc;
  final BoolBloc termsBloc;

  BookingFormBloc({
    this.termsBloc,
    this.nameBloc,
    this.dateBloc,
    this.emailBloc,
    this.guestBloc,
  }) : super([
          nameBloc,
          dateBloc,
          emailBloc,
          guestBloc,
        ]) {
          termsBloc.state.listen((onData){
            dispatch(ValidFieldState(""));
          });
        }

  @override
  FormState<Booking> get initialState => FormState();

  @override
  Stream<FormState<Booking>> mapEventToState(FormFieldState event) async* {
    bool formIsValid = true;

    fieldBlocs.forEach((bloc) {
      if (!(bloc.currentState is ValidFieldState)) {
        formIsValid = false;
      }
    });

    int guests;
    try {
      guests = int.parse(guestBloc.currentState.text);
    } catch (e) {
      guests = 0;
    }

    formIsValid = formIsValid && termsBloc.currentState;

    yield FormState(
      formIsValid: formIsValid,
      data: Booking(
        name: nameBloc.currentState.text,
        organizerEmail: emailBloc.currentState.text,
        date: dateBloc.currentState.text,
        guests: guests,
      ),
    );
  }
}
