import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/barrel.dart';
import 'package:my_thai_star_flutter/ui/order/order_form_buttons.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_checkbox_tile.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/form/bloc_form_field.dart';
import 'package:my_thai_star_flutter/blocs/booking_bloc.dart';
import 'package:my_thai_star_flutter/blocs/booking_state.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';
import 'package:my_thai_star_flutter/ui/order/alert_card.dart';

///Defines the form part of the [OrderPage] & is responsible for
///setting up it's validation
///
///The [OrderForm] creates a set of [FieldBloc]s and a
///[FormValidationBloc] on creation. The [FieldBloc]s
///are then injected into the [FormValidationBloc].
///[FieldBloc]s are used to validate one field of a
///from, a [FormValidationBloc] checks if the complete
///form is valid.
class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  //Validation
  FormValidationBloc _formValidationBloc;
  CheckboxFieldBloc _termsBloc = CheckboxFieldBloc();
  NonEmptyFieldBloc _bookingTokeBloc = NonEmptyFieldBloc();

  TextEditingController _bookingTokenController = TextEditingController();

  @override
  void initState() {
    //Inject FieldBlocs into the FormValidationBloc
    _formValidationBloc = FormValidationBloc([_termsBloc, _bookingTokeBloc]);

    BookingState currentBookingState =
        BlocProvider.of<BookingBloc>(context).currentState;

    //If a booking token has been emitted by the BookingBloc,
    //put it into the booking token text field
    if (currentBookingState is ConfirmedBookingState) {
      _bookingTokenController.text = currentBookingState.token;
      _bookingTokeBloc.dispatch(currentBookingState.token);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<NonEmptyFieldBloc, ValidationState>(
          bloc: _bookingTokeBloc,
          builder: (context, ValidationState state) =>
              //Display the AlertCard if the _BookingTokenField is empty
              state is ValidState ? SizedBox() : AlertCard(),
        ),
        _BookingTokenField(
          bookingTokenBloc: _bookingTokeBloc,
          bookingTokenController: _bookingTokenController,
        ),
        BlocCheckboxTile(
          checkboxBloc: _termsBloc,
          label: Translation.of(context).get("formFields/terms"),
        ),
        OrderFormButtons(
          formValidationBloc: _formValidationBloc,
          bookingTokenController: _bookingTokenController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _termsBloc.dispose();
    _formValidationBloc.dispose();
    _bookingTokeBloc.dispose();

    super.dispose();
  }
}

///Defines the [BlocFormField] for the booking token
class _BookingTokenField extends StatelessWidget {
  final NonEmptyFieldBloc _bookingTokenBloc;
  final TextEditingController _bookingTokenController;

  const _BookingTokenField({
    Key key,
    @required NonEmptyFieldBloc bookingTokenBloc,
    @required TextEditingController bookingTokenController,
  })  : _bookingTokenBloc = bookingTokenBloc,
        _bookingTokenController = bookingTokenController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: UiHelper.standard_padding,
        left: UiHelper.standard_padding,
      ),
      child: BlocFormField(
        label: Translation.of(context).get("formFields/referenceNumber"),
        errorHint: Translation.of(context).get("formFields/referenceNumber"),
        formFieldBloc: _bookingTokenBloc,
        controller: _bookingTokenController,
      ),
    );
  }
}
