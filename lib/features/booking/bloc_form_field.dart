import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_validation_bloc.dart';

class BlocFormField extends StatelessWidget {
  final FormValidationBloc bloc;
  final TextEditingController controller;
  final String lable;
  final String errorHint;

  //Optional
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const BlocFormField({
    Key key,
    @required this.bloc,
    @required this.controller,
    @required this.lable,
    @required this.errorHint,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, ValidationState state) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: lable),
          keyboardType: keyboardType,
          onChanged: (String input) => bloc.dispatch(input),
          validator: (_) => validate(state),
          inputFormatters: inputFormatters,
        );
      },
    );
  }

  String validate(ValidationState state) {
    if (state == ValidationState.valid)
      return null;
    else
      return errorHint;
  }
}
