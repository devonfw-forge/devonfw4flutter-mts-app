import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_validation_bloc.dart';

class EmailValidationBloc extends FormValidationBloc {
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
