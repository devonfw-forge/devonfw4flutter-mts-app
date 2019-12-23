import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';

///Defines a [TextFormField] that uses a [FieldBloc]
///to handle it's State & validation.
///
///Whenever the text in [TextFormField] changes,
///it is dispatched to the [FieldBloc].
///The [BlocFormField._errorHint] is displayed based
///on the [ValidationState] of the [FieldBloc].
class BlocFormField extends StatelessWidget {
  static const int _errorMaxLines = 2;

  final FieldBloc _formFieldBloc;
  final String _label;
  final String _errorHint;

  //Optional
  final TextInputType _keyboardType;
  final List<TextInputFormatter> _inputFormatter;
  final TextEditingController _controller;

  const BlocFormField({
    Key key,
    @required formFieldBloc,
    @required label,
    @required errorHint,
    keyboardType,
    inputFormatter,
    controller,
  })  : _formFieldBloc = formFieldBloc,
        _label = label,
        _errorHint = errorHint,
        _keyboardType = keyboardType,
        _inputFormatter = inputFormatter,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, ValidationState>(
      bloc: _formFieldBloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: _label,
            errorMaxLines: _errorMaxLines,
            errorText: validate(state),
          ),
          keyboardType: _keyboardType,
          onChanged: (String input) => _formFieldBloc.dispatch(input),
          inputFormatters: _inputFormatter,
          controller: _controller,
        );
      },
    );
  }

  String validate(ValidationState state) {
    if (state is InvalidState)
      return _errorHint;
    else
      return null;
  }
}
