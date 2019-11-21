import 'dart:async';
import 'package:bloc/bloc.dart';

enum CheckboxActions {tap}

class CheckboxBloc extends Bloc<CheckboxActions, bool> {
  
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(CheckboxActions event) async* {
    yield !currentState;
  }
}
