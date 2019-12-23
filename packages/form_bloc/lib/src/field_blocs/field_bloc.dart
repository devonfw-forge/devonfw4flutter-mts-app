import 'package:bloc/bloc.dart';
import 'package:form_bloc/src/validation_state.dart';

///Responsible for asserting the [ValidationState] of one [FormField]
///
///T is the data typ of the [FormField]. (String, int, etc)
abstract class FieldBloc<T> extends Bloc<T, ValidationState<T>> {}
