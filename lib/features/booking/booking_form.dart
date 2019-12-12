import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

import 'package:my_thai_star_flutter/features/booking/blocs/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/bloc_form_field.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/date_validation_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/email_validation_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/guest_number_validation_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/name_validation_bloc.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd-MM-yyyy HH:mm");

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
  BoolBloc _termsBloc = BoolBloc();
  GuestNumberValidationBloc _guestNumberValidationBloc =
      GuestNumberValidationBloc();

  @override
  void initState() {
    _bookingBloc.state.listen(
      (BookingState state) {
        if (state is ConfirmedBookingState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Booking Confirmed!\n" +
                "Booking Number: " +
                state.bookingNumber),
          ));
        } else if (state is DeclinedBookingState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text("Booking Declined"),
          ));
        }
      },
    );

    super.initState();
  }

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
          BlocBuilder(
            bloc: _termsBloc,
            builder: (context, bool state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CheckboxListTile(
                    title: Text("Accept terms"),
                    onChanged: (_) => _termsBloc.dispatch(BoolBlocEvent.swap),
                    value: state,
                  ),
                  RaisedButton(
                    child: Text(
                      "Book Table",
                    ),
                    textColor: Colors.white,
                    disabledTextColor: Colors.white,
                    onPressed: state ? () => _sendBooking() : null,
                  ),
                ],
              );
            },
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
    _termsBloc.dispose();

    _emailController.dispose();
    _nameController.dispose();
    _guestController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  void _sendBooking() {
    if (_formKey.currentState.validate()) {
      Booking booking = Booking(
        organizerEmail: _emailController.text,
        date: _dateController.text,
        name: _nameController.text,
        guests: int.parse(_guestController.text),
      );

      _bookingBloc.dispatch(booking);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1, microseconds: 50),
        content: Text("Please fill out the Form"),
      ));
    }
  }
}
