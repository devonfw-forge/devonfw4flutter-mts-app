import 'package:bloc/bloc.dart';
import 'package:form_bloc/src/validation_state.dart';

abstract class FieldBloc<T> extends Bloc<T, ValidationState<T>> {}
