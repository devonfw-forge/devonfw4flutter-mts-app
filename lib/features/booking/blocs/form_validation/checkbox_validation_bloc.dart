import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_validation_bloc.dart';


class CheckboxValidationBloc extends FormFieldBloc<bool> {
  @override
  Stream<ValidationState> mapEventToState(bool event) async* {
    if (event)
      yield ValidationState.valid;
    else
      yield ValidationState.invalid;
  }
}
