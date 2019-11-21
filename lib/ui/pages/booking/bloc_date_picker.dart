import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/form_validation_bloc.dart';

class BlocDatePicker extends StatelessWidget {
  final FormValidationBloc bloc;
  final TextEditingController controller;
  final format;
  final String lable;
  final String errorHint;

  const BlocDatePicker({
    Key key,
    @required this.bloc,
    @required this.controller,
    @required this.format,
    @required this.lable,
    @required this.errorHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, ValidationState state) {
        return DateTimeField(
          readOnly: true,
          controller: controller,
          format: format,
          decoration: InputDecoration(labelText: lable),
          validator: (_) => validate(state),
          onChanged: (DateTime input) {
            bloc.dispatch(input == null ? "" : input.toString());
          },
          onShowPicker: (context, currentValue) =>
              onShowPicker(context, currentValue),
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
