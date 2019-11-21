import 'package:bloc/bloc.dart';

enum ValidationState {valid, invalid}

abstract class FormValidationBloc extends Bloc<String, ValidationState> {

  @override
  ValidationState get initialState => ValidationState.invalid;
}
