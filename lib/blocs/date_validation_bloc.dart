import 'dart:async';
import 'dart:developer';
import 'package:my_thai_star_flutter/blocs/form_validation_bloc.dart';

class DateValidationBloc extends FormValidationBloc {
  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield ValidationState.invalid;
    else
      yield ValidationState.valid;
  }
}
