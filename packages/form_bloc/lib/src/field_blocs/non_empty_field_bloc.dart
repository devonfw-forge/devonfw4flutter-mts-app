import 'dart:async';

import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

class NonEmptyFieldBloc extends FieldBloc<String> {
 
  @override
  ValidationState<String> get initialState => InitialState('');
 
  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield InvalidState(event);
    else
      yield ValidState(event);
  }
}
