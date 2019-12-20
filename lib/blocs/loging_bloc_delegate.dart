import 'package:bloc/bloc.dart';

class LogingBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(bloc.runtimeType.toString() +
        ':\t' +
        transition.currentState.toString() +
        ' + ' +
        transition.event.toString() +
        ' -> ' +
        transition.nextState.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print(bloc.runtimeType.toString() + ':\t' + error.toString());
    super.onError(bloc, error, stacktrace);
  }
}
