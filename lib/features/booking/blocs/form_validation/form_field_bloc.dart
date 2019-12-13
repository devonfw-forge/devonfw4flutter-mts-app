import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart';

abstract class FormFieldBloc extends Bloc<String, FormFieldState> {

  @override
  FormFieldState get initialState => InitialFieldState("");
}
