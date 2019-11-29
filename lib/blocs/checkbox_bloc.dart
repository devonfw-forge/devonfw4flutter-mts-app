import 'dart:async';
import 'package:bloc/bloc.dart';

enum CheckboxEvent {tap}

class CheckboxBloc extends Bloc<CheckboxEvent, bool> {
  
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(CheckboxEvent event) async* {
    yield !currentState;
  }
}
