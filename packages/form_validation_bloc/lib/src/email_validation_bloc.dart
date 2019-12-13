import 'dart:async';

import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart';

class EmailValidationBloc extends FormFieldValidationBloc<String> {
  final RegExp emailPattern = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  
  @override
  ValidationState<String> get initialState => InitialState(null);
  
  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    if (emailPattern.hasMatch(event))
      yield ValidState(event);
    else
      yield InvalidState(event);
  }
}
