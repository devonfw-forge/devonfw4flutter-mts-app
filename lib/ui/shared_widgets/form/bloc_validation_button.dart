import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';

///Defines a [RaisedButton] that uses a [FormBaseBloc]
///to determine whether it is enabled or not
///
///The Button is enabled when the [FormBaseBloc] emits
///a [ValidState] and is disabled when the [FormBaseBloc] 
///emits an [InvalidState].
class BlocValidationButton extends StatelessWidget {
  final VoidCallback _onPressedWhenValid;
  final FormBaseBloc _formValidationBloc;
  final String _lable;

  const BlocValidationButton({
    Key key,
    bookingTokenController,
    formValidationBloc,
    onPressedWhenValid,
    lable,
  })  : _formValidationBloc = formValidationBloc,
        _onPressedWhenValid = onPressedWhenValid,
        _lable = lable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBaseBloc, ValidationState>(
      bloc: _formValidationBloc,
      builder: (context, ValidationState state) => RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        child: Text(_lable),
        //Enable/Disable based in ValidationState
        onPressed: state is ValidState ? () => _onPressedWhenValid() : null,
      ),
    );
  }
}
