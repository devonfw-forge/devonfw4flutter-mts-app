import 'package:bloc/bloc.dart';
import 'package:form_validation_bloc/src/validation_state.dart';

abstract class FormFieldValidationBloc<T> extends Bloc<T, ValidationState<T>> {}
