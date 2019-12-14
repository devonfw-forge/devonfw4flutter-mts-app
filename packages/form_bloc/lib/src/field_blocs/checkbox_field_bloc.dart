import 'dart:async';

import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

class CheckboxFieldBloc extends FieldBloc<bool> {
  @override
  ValidationState<bool> get initialState => InitialState(false);

  @override
  Stream<ValidationState<bool>> mapEventToState(bool event) async* {
    if (event)
      yield ValidState(event);
    else
      yield InvalidState(event);
  }
}
