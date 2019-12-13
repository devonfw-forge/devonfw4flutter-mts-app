import 'dart:async';

import 'form_field_validation_bloc.dart';

class NameValidationBloc extends FormFieldValidationBloc<String> {
  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield ValidationState.invalid;
    else
      yield ValidationState.valid;
  }
}
