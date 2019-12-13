import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/barrel.dart';

typedef StringCallback = void Function(String);

class BlocFormField extends StatelessWidget {
  final FormFieldValidationBloc validationBloc;
  final StringCallback onChange;
  final String label;
  final String errorHint;

  //Optional
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;

  const BlocFormField({
    Key key,
    @required this.validationBloc,
    @required this.label,
    @required this.errorHint,
    this.keyboardType,
    this.inputFormatters,
    this.onChange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFieldValidationBloc, ValidationState>(
      bloc: validationBloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          autovalidate: true,
          decoration: InputDecoration(labelText: label),
          keyboardType: keyboardType,
          onChanged: (String input) {
            validationBloc.dispatch(input);
            onChange(input);
          },
          validator: (_) => validate(state),
          inputFormatters: inputFormatters,
          controller: controller,
        );
      },
    );
  }

  String validate(ValidationState state) {
    if (state == ValidationState.invalid)
      return errorHint;
    else
      return null;
  }
}
