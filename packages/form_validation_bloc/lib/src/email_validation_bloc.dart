import 'dart:async';

import 'form_field_validation_bloc.dart';

class EmailValidationBloc extends FormFieldValidationBloc<String> {
  final RegExp emailPattern = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (emailPattern.hasMatch(event))
      yield ValidationState.valid;
    else
      yield ValidationState.invalid;
  }
}
