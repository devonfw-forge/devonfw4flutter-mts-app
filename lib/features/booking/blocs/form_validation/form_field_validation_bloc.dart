import 'package:bloc/bloc.dart';

enum ValidationState { initial, valid, invalid }

abstract class FormFieldBloc<T> extends Bloc<T, ValidationState> {
  @override
  ValidationState get initialState => ValidationState.initial;
}
