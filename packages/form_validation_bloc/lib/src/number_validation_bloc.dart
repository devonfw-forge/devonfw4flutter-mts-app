import 'dart:async';

import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart';

class NumberValidationBloc extends FormFieldValidationBloc<String> {
  @override
  ValidationState<String> get initialState => InitialState(null);

  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    try {
      int number = int.parse(event);
      if (number < 1) {
        yield InvalidState(event);
      } else {
        yield ValidState(event);
      }
    } catch (e) {
      yield InvalidState(event);
    }
  }
}
