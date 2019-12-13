import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart' as formBloc;

class BlocFormField extends StatelessWidget {
  final FormFieldBloc bloc;
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
    return BlocBuilder<FormFieldBloc, formBloc.FormFieldState>(
      bloc: bloc,
      builder: (context, formBloc.FormFieldState state) {
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

  String validate(formBloc.FormFieldState state) {
    if (state is formBloc.InvalidFieldState)
      return errorHint;
    else
      return null;
  }
}
