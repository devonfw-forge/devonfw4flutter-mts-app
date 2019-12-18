import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_form_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_checkbox_tile.dart';

import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_form_field.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_validation_button.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/sized_loading.dart';

class BookingForm extends StatefulWidget {

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  //Validation
  EmailFieldBloc _emailBloc = EmailFieldBloc();
  DateFieldBloc _dateBloc = DateFieldBloc(Booking.dateFormat);
  NonEmptyFieldBloc _nameBloc = NonEmptyFieldBloc();
  NumberFieldBloc _guestBloc = NumberFieldBloc();
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
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

    _setUpBookingResponses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BlocDatePicker(
            formFieldBloc: _dateBloc,
            lable: LocalizationBloc.of(context).get("formFields/dateTime"),
            errorHint: "Please select a Date",
            format: Booking.dateFormat,
          ),
          BlocFormField(
            formFieldBloc: _nameBloc,
            label: LocalizationBloc.of(context).get("formFields/name"),
            errorHint: LocalizationBloc.of(context)
                .get("bookTable/formErrors/nameRequired"),
          ),
          BlocFormField(
            formFieldBloc: _emailBloc,
            label: LocalizationBloc.of(context).get("formFields/email"),
            errorHint: LocalizationBloc.of(context)
                .get("bookTable/formErrors/emailPattern"),
            keyboardType: TextInputType.emailAddress,
          ),
          BlocFormField(
            formFieldBloc: _guestBloc,
            label: LocalizationBloc.of(context).get("formFields/guests"),
            errorHint: LocalizationBloc.of(context)
                .get("bookTable/formErrors/assistantsRequired"),
            inputFormatter: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
          ),
          BlocCheckboxTile(
            checkboxBloc: _termsBloc,
            label: LocalizationBloc.of(context).get("formFields/terms"),
          ),
          BlocBuilder<BookingBloc, BookingState>(
            builder: (context, BookingState state) {
              if (state is LoadingBookingState) {
                return SizedLoading();
              } else {
                return BlocValidationButton(
                  formValidationBloc: _formBloc,
                  lable: LocalizationBloc.of(context).get("buttons/bookTable"),
                  onPressedWhenValid: () =>
                      BlocProvider.of<BookingBloc>(context)
                          .dispatch(_formBloc.currentState.data),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailBloc.dispose();
    _nameBloc.dispose();
    _guestBloc.dispose();
    _dateBloc.dispose();
    _termsBloc.dispose();

    _formBloc.dispose();

    super.dispose();
  }

  void _setUpBookingResponses() {
    BlocProvider.of<BookingBloc>(context).state.skip(1).listen(
      (BookingState state) {
        if (state is ConfirmedBookingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ResponseDialog(
              headline: LocalizationBloc.of(context)
                  .get("bookTable/dialog/bookingSuccess"),
              body: LocalizationBloc.of(context)
                  .get("formFields/referenceNumber"),
              copyableText: state.token,
            ),
          );
        } else if (state is DeclinedBookingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ResponseDialog(
              headline: LocalizationBloc.of(context)
                  .get("bookTable/dialog/bookingError"),
              body: state.reason,
            ),
          );
        }
      },
    );
  }
}
