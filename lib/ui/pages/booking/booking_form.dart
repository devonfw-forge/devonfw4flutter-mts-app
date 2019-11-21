import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/date_validation_bloc.dart';
import 'package:my_thai_star_flutter/blocs/email_validation_bloc.dart';
import 'package:my_thai_star_flutter/blocs/form_validation_bloc.dart';
import 'package:my_thai_star_flutter/blocs/guest_number_validation_bloc.dart';
import 'package:my_thai_star_flutter/blocs/name_validation_bloc.dart';
import 'package:my_thai_star_flutter/models/booking.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy HH:mm");
  bool conditionsAccepted = false;

  //Text Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _guestController = TextEditingController();

  //BLoCs
  BookingBloc _bookingBloc = BookingBloc();

  EmailValidationBloc _emailValidationBloc = EmailValidationBloc();
  DateValidationBloc _dateValidationBloc = DateValidationBloc();
  NameValidationBloc _nameValidationBloc = NameValidationBloc();
  GuestNumberValidationBloc _guestNumberValidationBloc =
      GuestNumberValidationBloc();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BlocBuilder(
            bloc: _dateValidationBloc,
            builder: (context, ValidationState state) {
              return DateTimeField(
                readOnly: true,
                controller: _dateController,
                format: format,
                decoration: InputDecoration(labelText: 'Date and Time'),
                validator: (_) => _validateDate(state),
                onChanged: (DateTime input) {
                  _dateValidationBloc
                      .dispatch(input == null ? "" : input.toString());
                },
                onShowPicker: (context, currentValue) =>
                    onShowPicker(context, currentValue),
              );
            },
          ),
          BlocBuilder(
            bloc: _nameValidationBloc,
            builder: (context, ValidationState state) {
              return TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                onChanged: (String input) =>
                    _nameValidationBloc.dispatch(input),
                validator: (_) => _validateName(state),
              );
            },
          ),
          BlocBuilder(
            bloc: _emailValidationBloc,
            builder: (context, ValidationState state) {
              return TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String input) =>
                    _emailValidationBloc.dispatch(input),
                validator: (_) => _validateEmail(state),
              );
            },
          ),
          BlocBuilder(
            bloc: _guestNumberValidationBloc,
            builder: (context, ValidationState state) {
              return TextFormField(
                decoration: InputDecoration(labelText: 'Table Guests'),
                controller: _guestController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                onChanged: (String input) =>
                    _guestNumberValidationBloc.dispatch(input),
                validator: (_) => _validateGuests(state),
              );
            },
          ),
          CheckboxListTile(
            title: Text("Accept terms"),
            onChanged: (_) {
              setState(() {
                conditionsAccepted = !conditionsAccepted;
              });
            },
            value: conditionsAccepted,
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              "Book Table",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () => _sendBooking(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bookingBloc.dispose();

    _emailValidationBloc.dispose();
    _nameValidationBloc.dispose();
    _guestNumberValidationBloc.dispose();
    _dateValidationBloc.dispose();

    _emailController.dispose();
    _nameController.dispose();
    _guestController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  //Validation ------------

  String _validateDate(ValidationState state) {
    if (state == ValidationState.valid)
      return null;
    else
      return "Please select a Date";
  }

  String _validateEmail(ValidationState state) {
    if (state == ValidationState.valid)
      return null;
    else
      return "Enter valid Email";
  }

  String _validateName(ValidationState state) {
    if (state == ValidationState.valid)
      return null;
    else
      return 'Please enter your Name.';
  }

  String _validateGuests(ValidationState state) {
    if (state == ValidationState.valid)
      return null;
    else
      return 'Please enter the Number of Guests.';
  }

  //CallBacks ------------

  void _sendBooking() {
    if (_formKey.currentState.validate()) {
      Booking booking = Booking(
        organizerEmail: _emailController.text,
        date: _dateController.text,
        name: _nameController.text,
        guests: int.parse(_guestController.text),
      );

      _bookingBloc.dispatch(booking);
    }
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
