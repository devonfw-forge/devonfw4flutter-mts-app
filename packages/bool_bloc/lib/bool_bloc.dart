import 'dart:async';
import 'package:bloc/bloc.dart';

///Enable the manipulation of the bool-state
enum BoolBlocEvent {swap, setTrue, setFalse}

///Responsible for tracking the state of a single bool
///
///Consumes [BoolBlocEvent]s and mutates the current state accordingly. 
///It then emits a new [bool] as state.
class BoolBloc extends Bloc<BoolBlocEvent, bool> {
  
  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(BoolBlocEvent event) async* {
    if(event == BoolBlocEvent.swap) yield !currentState;
    else if(event == BoolBlocEvent.setTrue) yield true;
    else if(event == BoolBlocEvent.setFalse) yield false;
  }
}
