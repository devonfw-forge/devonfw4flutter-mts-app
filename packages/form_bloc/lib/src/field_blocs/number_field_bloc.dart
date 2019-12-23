import 'dart:async';

import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

///Responsible for checking if a given String consist of numbers
///greater then 0
class NumberFieldBloc extends FieldBloc<String> {
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
