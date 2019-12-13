import 'package:bool_bloc/bool_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/booking_form_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/form_bloc.dart'
    as formBloc;
import 'package:my_thai_star_flutter/features/booking/models/booking.dart';

import 'package:my_thai_star_flutter/features/booking/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/features/booking/bloc_form_field.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/date_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/email_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/number_field_bloc.dart';
import 'package:my_thai_star_flutter/features/booking/blocs/form_validation/name_field_bloc.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  //BLoCs
  BookingBloc _bookingBloc = BookingBloc();

  //Validation
  EmailFieldBloc _emailBloc = EmailFieldBloc();
  DateFieldBloc _dateBloc = DateFieldBloc();
  NameFieldBloc _nameBloc = NameFieldBloc();
  NumberFieldBloc _guestBloc = NumberFieldBloc();
  BoolBloc _termsBloc = BoolBloc();
  BookingFormBloc _formBloc;

  @override
  void initState() {
    _formBloc = BookingFormBloc(
      emailBloc: _emailBloc,
      dateBloc: _dateBloc,
      nameBloc: _nameBloc,
      guestBloc: _guestBloc,
      termsBloc: _termsBloc,
    );

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BlocDatePicker(
            bloc: _dateBloc,
            lable: 'Date and Time',
            errorHint: "Please select a Date",
            format: Booking.dateFormat,
          ),
          BlocFormField(
            bloc: _nameBloc,
            label: "Name",
            errorHint: 'Please enter your Name.',
          ),
          BlocFormField(
            bloc: _emailBloc,
            label: "Email",
            errorHint: "Enter valid Email",
            keyboardType: TextInputType.emailAddress,
          ),
          BlocFormField(
            bloc: _guestBloc,
            label: 'Table Guests',
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
                ],
              );
            },
          ),
          BlocBuilder<BookingFormBloc, formBloc.FormState<Booking>>(
            bloc: _formBloc,
            builder: (context, formBloc.FormState<Booking> state) {
              return RaisedButton(
                child: Text(
                  "Book Table",
                ),
                textColor: Colors.white,
                disabledTextColor: Colors.white,
                onPressed: state.formIsValid
                    ? () => _bookingBloc.dispatch(_formBloc.currentState.data)
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

    _formBloc.dispose();

    super.dispose();
  }
}
