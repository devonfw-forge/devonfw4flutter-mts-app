import 'package:form_bloc/barrel.dart';
import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

class FormValidationBloc extends FormBaseBloc<dynamic> {
  FormValidationBloc(List<FieldBloc> fieldBlocs) : super(fieldBlocs);

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
