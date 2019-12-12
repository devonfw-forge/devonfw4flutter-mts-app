import 'dart:async';
import 'package:bloc/bloc.dart';

enum BoolBlocEvent {swap, setTrue, setFalse}

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
