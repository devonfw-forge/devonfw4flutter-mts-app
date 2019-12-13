import 'dart:async';

import 'package:form_validation_bloc/barrel.dart';
import 'package:form_validation_bloc/src/validation_state.dart';
import 'package:intl/intl.dart';

import 'form_field_validation_bloc.dart';

class DateValidationBloc extends FormFieldValidationBloc<String> {
  final DateFormat format;

  DateValidationBloc(this.format);

  @override
  ValidationState<String> get initialState => InitialState("");

  @override
  Stream<ValidationState<String>> mapEventToState(String event) async* {
    if (event.isEmpty) {
      yield InvalidState(event);
    } else {
      try {
        DateTime date = format.parse(event);
        if (date != null) {
          yield ValidState(event);
        } else {
          InvalidState(event);
        }
      } catch (e) {
        yield InvalidState(event);
      }
    }
  }
}
