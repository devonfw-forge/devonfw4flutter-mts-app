import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(bloc.runtimeType.toString() +
        ":\t" +
        transition.currentState.runtimeType.toString() +
        " + " +
        transition.event.runtimeType.toString() +
        " -> " +
        transition.nextState.runtimeType.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(bloc.runtimeType.toString() + ":\t" + error.toString());
    super.onError(bloc, error, stacktrace);
  }
}
