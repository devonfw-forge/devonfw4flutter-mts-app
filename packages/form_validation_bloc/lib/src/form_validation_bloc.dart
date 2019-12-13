import 'package:form_validation_bloc/barrel.dart';
import 'package:form_validation_bloc/src/validation_state.dart';

import 'form_field_validation_bloc.dart'; 

class FormValidationBloc extends FormBloc<dynamic> {
  FormValidationBloc(List<FormFieldValidationBloc> fieldBlocs) : super(fieldBlocs);

  @override
  ValidationState get initialState => InitialState(null);

  @override
  Stream<ValidationState> mapEventToState(FormEvent event) async* {
    if(isFormValid()){
      yield ValidState(null);
    }else{
      yield InvalidState(null);
    }
  }
}
