import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../packages/form_validation_bloc/lib/form_field_validation_bloc.dart';

class BlocFormField extends StatelessWidget {
  final FormFieldValidationBloc bloc;
  final String label;
  final String errorHint;

  //Optional
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const BlocFormField({
    Key key,
    @required this.bloc,
    @required this.label,
    @required this.errorHint,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFieldValidationBloc, ValidationState>(
      bloc: bloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: label,
            errorText: validate(state),
          ),
          keyboardType: keyboardType,
          onChanged: (String input) => bloc.dispatch(input),
          inputFormatters: inputFormatters,
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
