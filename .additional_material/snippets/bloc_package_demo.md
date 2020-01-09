```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewBloc>(
      //Provide NewBloc to all descendants in the tree
      builder: (BuildContext context) => NewBloc(),
      child: Container(
        child: BlocBuilder<NewBloc, State>(
          //subscribe to the state emitted by NewBloc.
          //Rebuild descendants every time new
          //state is emitted.
          builder: (context, state) {
            //Display UI based on the state of NewBloc
            if (state is StateA) return WidgetA();
            if (state is StateB) return WidgetB();
            else {
              ///Access newBloc and dispatch a an event
              BlocProvider.of<NewBloc>(context).dispatch(Event());
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
```