import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_form_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/models/booking.dart';
import 'package:form_bloc/barrel.dart';

import 'package:my_thai_star_flutter/ui/booking/bloc_date_picker.dart';
import 'package:my_thai_star_flutter/ui/booking/bloc_form_field.dart';
import 'package:my_thai_star_flutter/localization/mts-localization.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key key}) : super(key: key);

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
            lable: MtsLocalization.of(context).get("formFields/dateTime"),
            errorHint: "Please select a Date",
            format: Booking.dateFormat,
          ),
          BlocFormField(
            formFieldBloc: _nameBloc,
            label: MtsLocalization.of(context).get("formFields/name"),
            errorHint: MtsLocalization.of(context)
                .get("bookTable/formErrors/nameRequired"),
          ),
          BlocFormField(
            formFieldBloc: _emailBloc,
            label: MtsLocalization.of(context).get("formFields/email"),
            errorHint: MtsLocalization.of(context)
                .get("bookTable/formErrors/emailPattern"),
            keyboardType: TextInputType.emailAddress,
          ),
          BlocFormField(
            formFieldBloc: _guestBloc,
            label: MtsLocalization.of(context).get("formFields/guests"),
            errorHint: MtsLocalization.of(context)
                .get("bookTable/formErrors/assistantsRequired"),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
          ),
          BlocBuilder<CheckboxFieldBloc, ValidationState>(
            bloc: _termsBloc,
            builder: (context, ValidationState state) => _TermsCheckbox(
              state: state,
              termsBloc: _termsBloc,
            ),
          ),
          BlocBuilder<BookingBloc, BookingState>(
            builder: (context, BookingState state) {
              if (state is LoadingBookingState) {
                return _Loading();
              } else {
                return _Button(formBloc: _formBloc);
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
            builder: (BuildContext context) => ResponseDialoge(
              headline: MtsLocalization.of(context)
                  .get("bookTable/dialog/bookingSuccess"),
              body: MtsLocalization.of(context).get("formFields/referenceNumber"),
              copyableText: state.token,
            ),
          );
        } else if (state is DeclinedBookingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ResponseDialoge(
              headline: MtsLocalization.of(context).get("bookTable/dialog/bookingError"),
              body: state.reason,
            ),
          );
        }
      },
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({
    Key key,
    @required CheckboxFieldBloc termsBloc,
    @required ValidationState state,
  })  : _termsBloc = termsBloc,
        _state = state,
        super(key: key);

  final CheckboxFieldBloc _termsBloc;
  final ValidationState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        CheckboxListTile(
          title: Text(MtsLocalization.of(context).get("formFields/terms")),
          onChanged: (bool value) => _termsBloc.dispatch(value),
          value: _state is ValidState,
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.only(
        right: UiHelper.card_margin,
        top: UiHelper.standard_padding,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({Key key, @required BookingFormBloc formBloc})
      : _formBloc = formBloc,
        super(key: key);

  final BookingFormBloc _formBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingFormBloc, ValidationState>(
      bloc: _formBloc,
      builder: (context, ValidationState state) => RaisedButton(
        child: Text(MtsLocalization.of(context).get("buttons/bookTable")),
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        onPressed: state is ValidState
            ? () => BlocProvider.of<BookingBloc>(context)
                .dispatch(_formBloc.currentState.data)
            : null,
      ),
    );
  }
}
