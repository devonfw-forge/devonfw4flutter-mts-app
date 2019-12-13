import 'dart:async';

import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart';

class NonEmptyValidationBloc extends FormFieldValidationBloc<String> {
 
  @override
  ValidationState<String> get initialState => InitialState("");
 
  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield InvalidState(event);
    else
      yield ValidState(event);
  }
}
