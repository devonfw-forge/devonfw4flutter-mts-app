import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:intl/intl.dart';

///Defines a [DateTimeField] that uses a [FieldBloc]
///to handle it's State & validation.
///
///When tapped, the [BlocDatePicker] displays a window to enable the
///selection of a date & time. Once date & time have been selected,
///they are dispatched to the [FieldBloc] for validation.
///the [BlocDatePicker._errorHint] is displayed based
///on the [ValidationState] of the [FieldBloc].
///The selected [DateTime] is dispatched as a [String]
///based on the [BlocDatePicker._format]. We send it as a String
///because the bloc_package dose not allow events to be null and 
///[DateTime] can't be initialized without a value. So if we wanted
///to dispatch events as [DateTime] we can't
///sent an event when no date is selected. With String events,
///we can send an empty String
class BlocDatePicker extends StatelessWidget {
  static final _lastDate = DateTime(2100);

  final FieldBloc _formFieldBloc;
  final TextEditingController _controller;
  final DateFormat _format;
  final String _lable;
  final String _errorHint;

  const BlocDatePicker({
    Key key,
    @required formFieldBloc,
    @required format,
    @required lable,
    @required errorHint,
    controller,
  })  : _formFieldBloc = formFieldBloc,
        _format = format,
        _lable = lable,
        _errorHint = errorHint,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldBloc, ValidationState>(
      bloc: _formFieldBloc,
      builder: (context, ValidationState state) {
        return DateTimeField(
          readOnly: true,
          format: _format,
          controller: _controller,
          decoration: InputDecoration(
            labelText: _lable,
            errorText: _validate(state),
          ),
          onChanged: (DateTime input) => _formFieldBloc
              .dispatch(input != null ? _format.format(input) : ''),
          onShowPicker: (context, currentValue) =>
              _onShowPicker(context, currentValue),
        );
      },
    );
  }

  String _validate(ValidationState state) {
    if (state is InvalidState)
      return _errorHint;
    else
      return null;
  }

  Future<DateTime> _onShowPicker(
      BuildContext context, DateTime currentValue) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: _getInitialDate(currentValue),
        lastDate: _lastDate);
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

  ///Makes sure that the initial date is not
  ///before the currentValue
  _getInitialDate(DateTime currentValue) {
    if (currentValue == null) {
      return DateTime.now();
    } else if (currentValue.isBefore(DateTime.now())) {
      return DateTime.now();
    } else {
      return currentValue;
    }
  }
}
