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
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_validation_button.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/response_dialoge.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/sized_loading.dart';

///Defines the form that is responsible for handleing the booking process
///
///The [BookingForm] was not implemented using Flutters in-built [Form].
///Instead a costume solution was built in the form of the 'form_bloc' package.
///This application follows the bloc-pattern for (almost) every  feature
///(except localization). Flutters standart [Form]s do not follow the bloc-
///pattern. Validation happens through functions in the interface and the state
///of the Form is tracked internally by the framework. It was decided to built a
///custom solution using bloc to keep the app consistent. There are other bloc based
///form packages out there but none of theme are consistently maintained, so I wrote
///my own. How it functions exactly is described in the package documention.
///
///The [BookingForm] initializes all [FieldBloc]s and the related [BookingFormBloc].
///Once all [FiledBloc]s and thus the [BookingFormBloc] is valid, the [Booking] can be
///send to the [BookingBloc].
class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  //Validation: FieldBlocs
  EmailFieldBloc _emailBloc = EmailFieldBloc();
  DateFieldBloc _dateBloc = DateFieldBloc(Booking.dateFormat);
  NonEmptyFieldBloc _nameBloc = NonEmptyFieldBloc();
  NumberFieldBloc _guestBloc = NumberFieldBloc();
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();

  //Validation: FormBloc
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        BlocDatePicker(
          formFieldBloc: _dateBloc,
          lable: Translation.of(context).get('formFields/dateTime'),
          errorHint: 'Please select a Date',
          format: Booking.dateFormat,
        ),
        BlocFormField(
          formFieldBloc: _nameBloc,
          label: Translation.of(context).get('formFields/name'),
          errorHint:
              Translation.of(context).get('bookTable/formErrors/nameRequired'),
        ),
        BlocFormField(
          formFieldBloc: _emailBloc,
          label: Translation.of(context).get('formFields/email'),
          errorHint:
              Translation.of(context).get('bookTable/formErrors/emailPattern'),
          keyboardType: TextInputType.emailAddress,
        ),
        BlocFormField(
          formFieldBloc: _guestBloc,
          label: Translation.of(context).get('formFields/guests'),
          errorHint: Translation.of(context)
              .get('bookTable/formErrors/assistantsRequired'),
          inputFormatter: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
        ),
        BlocCheckboxTile(
          checkboxBloc: _termsBloc,
          label: Translation.of(context).get('formFields/terms'),
        ),
        BlocBuilder<BookingBloc, BookingState>(
          builder: (context, BookingState state) {
            if (state is LoadingBookingState) {
              return SizedLoading();
            } else {
              //Button can only be pressed when the [FormBloc] is valid &
              //the [BookingBloc] is not loading
              return BlocValidationButton(
                formValidationBloc: _formBloc,
                lable: Translation.of(context).get('buttons/bookTable'),
                onPressedWhenValid: () => BlocProvider.of<BookingBloc>(context)
                    .dispatch(_formBloc.currentState.data),
              );
            }
          },
        ),
      ],
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

  ///Adds a listener to the [BookingBloc] that displays [ResponseDialog]s based
  ///on the emitted state
  ///
  ///Skips the first state to negate the fact that the bloc package
  ///implements the state stream as a [BehaviorSubject]. [BehaviorSubject]s
  ///always emit their last state when a new listener is added.
  ///We only want new state, otherwise the listeners get triggered every time we enter
  ///the page after we received a [ConfirmedBookingState] once.
  _setUpBookingResponses() {
    BlocProvider.of<BookingBloc>(context).state.skip(1).listen(
      (BookingState state) {
        if (state is ConfirmedBookingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ResponseDialog(
              headline: Translation.of(context)
                  .get('bookTable/dialog/bookingSuccess'),
              body: Translation.of(context).get('formFields/referenceNumber'),
              copyableText: state.token,
            ),
          );
        } else if (state is DeclinedBookingState) {
          showDialog(
            context: context,
            builder: (BuildContext context) => ResponseDialog(
              headline:
                  Translation.of(context).get('bookTable/dialog/bookingError'),
              body: state.reason,
            ),
          );
        }
      },
    );
  }
}
