import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_field_state.dart' as formBloc;

class BlocDatePicker extends StatelessWidget {
  final FormFieldBloc bloc;
  final format;
  final String lable;
  final String errorHint;

  const BlocDatePicker({
    Key key,
    @required this.bloc,
    @required this.format,
    @required this.lable,
    @required this.errorHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFieldBloc, formBloc.FormFieldState>(
      bloc: bloc,
      builder: (context, formBloc.FormFieldState state) {
        return DateTimeField(
          readOnly: true,
          format: format,
          decoration: InputDecoration(
            labelText: lable,
            errorText: validate(state),
          ),
          onChanged: (DateTime input) {
            bloc.dispatch(input == null
                ? ""
                : Booking.dateFormat.format(input).toString());
          },
          onShowPicker: (context, currentValue) =>
              onShowPicker(context, currentValue),
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

  Future<DateTime> onShowPicker(
      BuildContext context, DateTime currentValue) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: currentValue ?? DateTime.now(),
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
      );
      return DateTimeField.combine(date, time);
    } else {
      return currentValue;
    }
  }
}
