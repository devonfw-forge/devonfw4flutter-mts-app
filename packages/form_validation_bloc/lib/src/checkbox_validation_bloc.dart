import 'dart:async';

import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart';

class CheckboxValidationBloc extends FormFieldValidationBloc<bool> {
  @override
  ValidationState<bool> get initialState => InitialState(false);

  @override
  Stream<ValidationState<bool>> mapEventToState(bool event) async* {
    if (event)
      yield ValidState(event);
    else
      yield InvalidState(event);
  }
}
