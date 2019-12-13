import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_events.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';
import 'package:form_validation_bloc/barrel.dart';

import 'package:my_thai_star_flutter/features/booking/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/features/booking/bloc_form_field.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  //BLoCs
  BookingBloc _bookingBloc = BookingBloc();

  //Validation
  EmailValidationBloc _emailBloc = EmailValidationBloc();
  DateValidationBloc _dateBloc = DateValidationBloc();
  NameValidationBloc _nameBloc = NameValidationBloc();
  NumberValidationBloc _guestBloc = NumberValidationBloc();
  CheckboxValidationBloc _termsBloc = CheckboxValidationBloc();
  FormValidationBloc _formValidationBloc;

  @override
  void initState() {
    _formValidationBloc = FormValidationBloc([
      _emailBloc,
      _dateBloc,
      _nameBloc,
      _guestBloc,
      _termsBloc,
    ]);

    _bookingBloc.state.listen(
      (BookingState state) {
        if (state is ConfirmedBookingState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Booking Confirmed!\n" +
                "Booking Number: " +
                state.booking.bookingNumber),
          ));
        } else if (state is DeclinedBookingState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Booking Declined\nReason: " + state.reason),
          ));
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BlocDatePicker(
            validationBloc: _dateBloc,
            lable: 'Date and Time',
            errorHint: "Please select a Date",
            format: Booking.dateFormat,
            onChange: (DateTime date) =>
                _bookingBloc.dispatch(SetDateEvent(date)),
          ),
          BlocFormField(
            validationBloc: _nameBloc,
            label: "Name",
            errorHint: 'Please enter your Name.',
            onChange: (String name) =>
                _bookingBloc.dispatch(SetNameEvent(name)),
          ),
          BlocFormField(
            validationBloc: _emailBloc,
            label: "Email",
            errorHint: "Enter valid Email",
            keyboardType: TextInputType.emailAddress,
            onChange: (String email) =>
                _bookingBloc.dispatch(SetEmailEvent(email)),
          ),
          BlocFormField(
            validationBloc: _guestBloc,
            label: 'Table Guests',
            errorHint: 'Please enter the Number of Guests.',
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            onChange: (String guests) =>
                _bookingBloc.dispatch(SetGuestsEvent(int.parse(guests))),
          ),
          BlocBuilder<CheckboxValidationBloc, ValidationState>(
            bloc: _termsBloc,
            builder: (context, ValidationState state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CheckboxListTile(
                    title: Text("Accept terms"),
                    onChanged: (bool value) {
                      _termsBloc.dispatch(value);
                      _bookingBloc.dispatch(SetTermsAcceptedEvent(value));
                    },
                    value: state == ValidationState.valid,
                  ),
                ],
              );
            },
          ),
          BlocBuilder<FormValidationBloc, ValidationState>(
            bloc: _formValidationBloc,
            builder: (context, ValidationState state) {
              return RaisedButton(
                child: Text(
                  "Book Table",
                ),
                textColor: Colors.white,
                disabledTextColor: Colors.white,
                onPressed: state == ValidationState.valid
                    ? () => _bookingBloc.dispatch(RequestBookingEvent())
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bookingBloc.dispose();

    _emailBloc.dispose();
    _nameBloc.dispose();
    _guestBloc.dispose();
    _dateBloc.dispose();
    _termsBloc.dispose();

    _formValidationBloc.dispose();

    super.dispose();
  }
}
