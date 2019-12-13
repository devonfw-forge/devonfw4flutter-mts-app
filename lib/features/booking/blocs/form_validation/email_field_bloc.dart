import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';

class EmailFieldBloc extends FormFieldBloc {
  final RegExp emailPattern = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Stream<FormFieldState> mapEventToState(String event) async* {
    if (emailPattern.hasMatch(event))
      yield ValidFieldState(event);
    else
      yield InvalidFieldState(event);
  }
}
