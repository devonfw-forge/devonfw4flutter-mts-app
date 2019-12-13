import 'dart:async';

import 'form_field_validation_bloc.dart';

class NumberValidationBloc extends FormFieldValidationBloc<String> {
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
