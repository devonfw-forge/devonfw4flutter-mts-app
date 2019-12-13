import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_validation_bloc.dart';


class DateValidationBloc extends FormFieldValidationBloc<String> {
  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield ValidationState.invalid;
    else
      yield ValidationState.valid;
  }
}
