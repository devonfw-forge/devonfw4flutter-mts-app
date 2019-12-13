import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';
import 'package:form_validation_bloc/barrel.dart';

typedef DateCallback = void Function(DateTime);

class BlocDatePicker extends StatelessWidget {
  final FormFieldValidationBloc validationBloc;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFieldValidationBloc, ValidationState>(
      bloc: validationBloc,
      builder: (context, ValidationState state) {
        return DateTimeField(
          readOnly: true,
          format: format,
          decoration: InputDecoration(
            labelText: lable,
            errorText: validate(state),
          ),
          onChanged: (DateTime input) {
            validationBloc.dispatch(input == null
                ? ""
                : Booking.dateFormat.format(input).toString());

                onChange(input);
          },
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
        firstDate: DateTime(2010) ,
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
