import 'package:flutter/material.dart';
import 'package:form_bloc/form_bloc.dart';

///Handles the current state of the [OrderForm]
///
///When the [Bloc.currentState] of both the [termsBloc] and the [_tokenBloc] are
///[ValidState], the [OrderFormBloc] will emit a [ValidState] carrying the current
///booking token. 
///If any of the [Bloc.currentState] of the [termsBloc] and the [_tokenBloc]
///is [InvalidSate], [OrderFormBloc] will emit an [InvalidState].
class OrderFormBloc extends FormBaseBloc<String> {
  final NonEmptyFieldBloc _tokenBloc;

  OrderFormBloc({
    @required tokenBloc,
    @required termsBloc,
  })  : _tokenBloc = tokenBloc,
        super([
          tokenBloc,
          termsBloc
        ]);

  @override
  ValidationState<String> get initialState => InitialState('');

  ///Called every time one of the [FieldBloc]s of [FormBaseBloc] changes state
  @override
  Stream<ValidationState<String>> mapEventToState(FormEvent event) async* {
    if (isFormValid()) {
      yield ValidState(_tokenBloc.currentState.data);
    } else {
      yield InvalidState(_tokenBloc.currentState.data);
    }
  }
}
