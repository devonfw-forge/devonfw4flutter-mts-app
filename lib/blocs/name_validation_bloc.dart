import 'dart:async';
import 'package:my_thai_star_flutter/blocs/form_validation_bloc.dart';

class NameValidationBloc extends FormValidationBloc {
  @override
  Stream<ValidationState> mapEventToState(String event) async* {
    if (event.length < 3)
      yield ValidationState.invalid;
    else
      yield ValidationState.valid;
  }
}
