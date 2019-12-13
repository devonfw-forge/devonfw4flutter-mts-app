import 'package:bloc/bloc.dart';

import 'form_field_validation_bloc.dart';

class FormValidationBloc extends Bloc<ValidationState, ValidationState> {
  final List<FormFieldValidationBloc> fieldBlocs;

  FormValidationBloc(this.fieldBlocs) {
    fieldBlocs.forEach((bloc) {
      bloc.state.listen((onData) {
        dispatch(onData);
      });
    });
  }

  @override
  ValidationState get initialState => ValidationState.initial;

  @override
  Stream<ValidationState> mapEventToState(ValidationState event) async* {
    bool formIsValid = true;
    fieldBlocs.forEach((bloc) {
      if(bloc.currentState != ValidationState.valid) formIsValid = false;
    });

    if(formIsValid){
      yield ValidationState.valid;
    }else{
      yield ValidationState.invalid;
    }
  }
}

