import 'package:flutter/material.dart';
import 'package:form_bloc/barrel.dart';

class OrderFormBloc extends FormBaseBloc<String> {
  final NonEmptyFieldBloc _tokenBloc;
  final CheckboxFieldBloc _termsBloc;

  OrderFormBloc({
    @required tokenBloc,
    @required termsBloc,
  })  : _tokenBloc = tokenBloc,
        _termsBloc = termsBloc,
        super([
          tokenBloc,
          termsBloc,
        ]);

  @override
  ValidationState<String> get initialState => InitialState('');

  @override
  Stream<ValidationState<String>> mapEventToState(FormEvent event) async* {
    if (isFormValid()) {
      yield ValidState(_tokenBloc.currentState.data);
    } else {
      yield InvalidState(_tokenBloc.currentState.data);
    }
  }
}
