import 'dart:async';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';

class NameFieldBloc extends FormFieldBloc {
  @override
  Stream<FormFieldState> mapEventToState(String event) async* {
    if (event.isEmpty)
      yield InvalidFieldState(event);
    else
      yield ValidFieldState(event);
  }
}
