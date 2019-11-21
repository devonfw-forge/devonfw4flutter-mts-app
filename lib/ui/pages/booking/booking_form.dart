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
import 'package:my_thai_star_flutter/ui/pages/booking/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/ui/pages/booking/bloc_form_field.dart';

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
          BlocDatePicker(
            bloc: _dateValidationBloc,
            controller: _dateController,
            lable: 'Date and Time',
            errorHint: "Please select a Date",
            format: format,
          ),
          BlocFormField(
            bloc: _nameValidationBloc,
            controller: _nameController,
            lable: "Name",
            errorHint: 'Please enter your Name.',
          ),
          BlocFormField(
            bloc: _emailValidationBloc,
            controller: _emailController,
            lable: "Email",
            errorHint: "Enter valid Email",
            keyboardType: TextInputType.emailAddress,
          ),
          BlocFormField(
            bloc: _guestNumberValidationBloc,
            controller: _guestController,
            lable: 'Table Guests',
            errorHint: 'Please enter the Number of Guests.',
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
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
}
