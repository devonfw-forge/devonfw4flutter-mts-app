import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';

class NumberFieldBloc extends FormFieldBloc {
  @override
  Stream<FormFieldState> mapEventToState(String event) async* {
    if (event.isEmpty) {
      yield InvalidFieldState(event);
      return;
    }

    int guests;
    try {
      guests = int.parse(event);
      if (guests > 0) {
        yield ValidFieldState(event);
      } else {
        yield InvalidFieldState(event);
      }
    } catch (e) {
      yield InvalidFieldState(event);
    }
  }
}
