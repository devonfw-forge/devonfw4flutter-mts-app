import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:intl/intl.dart';

class BlocDatePicker extends StatelessWidget {
  final FieldBloc formFieldBloc;
  final TextEditingController controller;
  final DateFormat format;
  final String lable;
  final String errorHint;

  const BlocDatePicker({
    Key key,
    @required this.formFieldBloc,
    @required this.format,
    @required this.lable,
    @required this.errorHint,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, ValidationState>(
      bloc: formFieldBloc,
      builder: (context, ValidationState state) {
        return DateTimeField(
          readOnly: true,
          format: format,
          controller: controller,
          decoration: InputDecoration(
            labelText: lable,
            errorText: validate(state),
          ),
          onChanged: (DateTime input) {
            formFieldBloc.dispatch(input != null ? format.format(input) : "");
          },
          onShowPicker: (context, currentValue) =>
              onShowPicker(context, currentValue),
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

  Future<DateTime> onShowPicker(
      BuildContext context, DateTime currentValue) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: getInitialDate(currentValue),
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

  getInitialDate(DateTime currentValue) {
    if (currentValue == null)
      return DateTime.now();
    else if (currentValue.isBefore(DateTime.now()))
      return DateTime.now();
    else
      return currentValue;
  }
}
