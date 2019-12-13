import 'dart:async';

import 'form_field_validation_bloc.dart';


class CheckboxValidationBloc extends FormFieldValidationBloc<bool> {
  @override
  Stream<ValidationState> mapEventToState(bool event) async* {
    if (event)
      yield ValidationState.valid;
    else
      yield ValidationState.invalid;
  }
}
