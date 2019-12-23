import 'package:form_bloc/form_bloc.dart';
import 'package:form_bloc/src/validation_state.dart';

import 'package:form_bloc/src/field_blocs/field_bloc.dart';

///Responsible for tracking the [ValidationState] of a from
///
///This implementation of the [FormBaseBloc] does not keep track of
///the data in the form, but only of the [ValidationState].
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
