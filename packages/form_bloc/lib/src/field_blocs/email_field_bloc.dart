import 'dart:async';

import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

class EmailFieldBloc extends FieldBloc<String> {
  static final RegExp _emailPattern = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  
  @override
  ValidationState<String> get initialState => InitialState(null);
  
  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    if (_emailPattern.hasMatch(event))
      yield ValidState(event);
    else
      yield InvalidState(event);
  }
}
