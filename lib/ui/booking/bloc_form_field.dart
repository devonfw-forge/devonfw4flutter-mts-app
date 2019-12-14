import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';

typedef StringCallback = void Function(String);

class BlocFormField extends StatelessWidget {
  final FieldBloc formFieldBloc;
  final String label;
  final String errorHint;

  //Optional
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  const BlocFormField({
    Key key,
    @required this.formFieldBloc,
    @required this.label,
    @required this.errorHint,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, ValidationState>(
      bloc: formFieldBloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: label,
            errorText: validate(state),
          ),
          keyboardType: keyboardType,
          onChanged: (String input) => formFieldBloc.dispatch(input),
          inputFormatters: inputFormatters,
          controller: controller,
        );
      },
    );
  }

  String validate(ValidationState state) {
    if (state is InvalidState)
      return errorHint;
    else
      return null;
  }
}
