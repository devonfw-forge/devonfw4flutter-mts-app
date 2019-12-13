import 'package:bloc/bloc.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';

abstract class FormBloc<E> extends Bloc<FormFieldState, FormState<E>> {
  final List<FormFieldBloc> fieldBlocs;

  FormBloc(this.fieldBlocs) {
    fieldBlocs.forEach((bloc) {
      bloc.state.listen((onData) {
        dispatch(onData);
      });
    });
  }
}

class FormState<E> {
  E data;
  bool formIsValid = false;

  FormState({this.data, this.formIsValid});
}
