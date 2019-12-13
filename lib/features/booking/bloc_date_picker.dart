import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';
import 'package:form_validation_bloc/barrel.dart';

typedef DateCallback = void Function(DateTime);

class BlocDatePicker extends StatelessWidget {
  final FormFieldValidationBloc validationBloc;
  final TextEditingController controller;
  final DateCallback onChange;
  final format;
  final String lable;
  final String errorHint;

  const BlocDatePicker({
    Key key,
    @required this.validationBloc,
    @required this.format,
    @required this.lable,
    @required this.errorHint,
    this.onChange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFieldValidationBloc, ValidationState>(
      bloc: validationBloc,
      builder: (context, ValidationState state) {
        return DateTimeField(
          autovalidate: true,
          readOnly: true,
          format: format,
          controller: controller,
          decoration: InputDecoration(
            labelText: lable,
          ),
          onChanged: (DateTime input) {
            validationBloc.dispatch(input == null
                ? ""
                : Booking.dateFormat.format(input).toString());

            onChange(input);
          },
          validator: (_) => validate(state),
          onShowPicker: (context, currentValue) =>
              onShowPicker(context, currentValue),
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
