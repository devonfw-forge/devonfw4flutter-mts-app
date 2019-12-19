import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';

///Defines a [CheckboxListTile] that uses a [CheckboxFieldBloc]
///to handle it's State.
///
///The CheckBox is checked when tapped and makes the 
///[CheckboxFieldBloc] emit [ValidationState.valid] or 
///[ValidationState.invalid] based on if the box
///is checked or not.
class BlocCheckboxTile extends StatelessWidget {
  const BlocCheckboxTile({
    Key key,
    @required CheckboxFieldBloc checkboxBloc,
    @required String label,
  })  : _checkboxBloc = checkboxBloc,
        _label = label,
        super(key: key);

  final CheckboxFieldBloc _checkboxBloc;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckboxFieldBloc, ValidationState>(
      bloc: _checkboxBloc,
      builder: (context, ValidationState state) => CheckboxListTile(
        title: Text(_label),
        value: state is ValidState,
        onChanged: (bool val) => _checkboxBloc.dispatch(val),
      ),
    );
  }
}