import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_validation_bloc.dart';

class NumberFieldBloc extends FormFieldBloc<String> {
  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (event.isEmpty) {
      yield ValidationState.invalid;
      return;
    }

    int guests;
    try {
      guests = int.parse(event);
      if (guests > 0) {
        yield ValidationState.valid;
      } else {
        yield ValidationState.invalid;
      }
    } catch (e) {
      yield ValidationState.invalid;
    }
  }
}
