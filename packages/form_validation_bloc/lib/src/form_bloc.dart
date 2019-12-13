import 'package:bloc/bloc.dart';
import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart';

enum FormEvent { notify }

abstract class FormBloc<T> extends Bloc<FormEvent, ValidationState<T>> {
  final List<FormFieldValidationBloc> fieldBlocs;

  FormBloc(this.fieldBlocs) {
    fieldBlocs.forEach((bloc) {
      bloc.state.listen((_) {
        dispatch(FormEvent.notify);
      });
    });
  }

  bool isFormValid() {
    bool formIsValid = true;
    fieldBlocs.forEach((bloc) {
      if (!(bloc.currentState is ValidState)) formIsValid = false;
    });

    return formIsValid;
  }
}
